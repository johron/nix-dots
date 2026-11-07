{ pkgs, lib, config, ... }:

let
  repoUrl = "https://github.com/johron/johron.no";
  image = "localhost/johron-no:latest";
  dataDir = "/opt/docker-containers/johron-no";
  srcDir = "${dataDir}/src";
  pollInterval = "5min";

  dockerfile = pkgs.writeText "johron-no.Dockerfile" ''
    FROM node:22-alpine AS base
    RUN apk add --no-cache libc6-compat
    ENV COREPACK_ENABLE_DOWNLOAD_PROMPT=0 \
        NEXT_TELEMETRY_DISABLED=1
    RUN corepack enable
    WORKDIR /app

    # Dependencies (cached as long as the lockfile is unchanged)
    FROM base AS deps
    COPY package.json pnpm-lock.yaml pnpm-workspace.yaml ./
    RUN pnpm install --frozen-lockfile

    # Build
    FROM base AS build
    COPY --from=deps /app/node_modules ./node_modules
    COPY . .
    RUN node_modules/.bin/next build

    # Runtime
    FROM node:22-alpine AS run
    RUN apk add --no-cache libc6-compat
    ENV NODE_ENV=production \
        NEXT_TELEMETRY_DISABLED=1 \
        HOSTNAME=0.0.0.0
    WORKDIR /app
    COPY --from=build --chown=node:node /app ./
    USER node
    EXPOSE 4000
    CMD ["node_modules/.bin/next", "start", "-p", "4000"]
  '';
in
{
  virtualisation.podman = {
    enable = true;
    autoPrune.enable = true;
    dockerCompat = true;
  };

  networking.firewall.interfaces = let
    matchAll = if !config.networking.nftables.enable then "podman+" else "podman*";
  in {
    "${matchAll}".allowedUDPPorts = [ 53 ];
  };

  virtualisation.oci-containers.backend = "podman";

  systemd.tmpfiles.rules = [
    "d /opt/docker-containers 0755 root root -"
    "d ${dataDir} 0755 root root -"
  ];

  virtualisation.oci-containers.containers."johron-no" = {
    inherit image;
    ports = [
      "127.0.0.1:4000:4000/tcp"
    ];
    log-driver = "journald";
    extraOptions = [
      "--network-alias=johron-no"
      "--cap-drop=ALL"
      "--security-opt=no-new-privileges"
    ];
  };

  systemd.services."podman-johron-no" = {
    serviceConfig = {
      Restart = lib.mkOverride 90 "always";
    };
    wants = [ "johron-no-sync.service" "network-online.target" ];
    after = [ "johron-no-sync.service" "network-online.target" ];
  };

  systemd.services."johron-no-sync" = {
    description = "Sync and rebuild johron.no image if upstream changed";
    path = [ pkgs.git pkgs.podman ];
    wants = [ "network-online.target" ];
    after = [ "network-online.target" ];
    serviceConfig = {
      Type = "oneshot";
      TimeoutStartSec = "30min";
    };
    script = ''
      set -euo pipefail

      export GIT_TERMINAL_PROMPT=0

      if [ ! -d "${srcDir}/.git" ]; then
        rm -rf "${srcDir}"
        git clone --depth 1 "${repoUrl}" "${srcDir}"
      fi

      git -C "${srcDir}" fetch --depth 1 origin HEAD
      new="$(git -C "${srcDir}" rev-parse FETCH_HEAD)"

      current="$(podman image inspect --format '{{ index .Labels "git.rev" }}' "${image}" 2>/dev/null || echo none)"

      if [ "$new" = "$current" ]; then
        echo "johron.no is up to date ($new)"
        exit 0
      fi

      echo "Building johron.no: $current -> $new"
      git -C "${srcDir}" reset --hard "$new"
      git -C "${srcDir}" clean -fdx

      podman build \
        --file ${dockerfile} \
        --tag "${image}" \
        --label "git.rev=$new" \
        "${srcDir}"

      podman image prune -f || true

      if systemctl is-active --quiet podman-johron-no.service; then
        echo "Restarting container"
        systemctl restart --no-block podman-johron-no.service
      fi
    '';
  };

  systemd.timers."johron-no-sync" = {
    description = "Periodically check for johron.no updates";
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnBootSec = "2min";
      OnUnitActiveSec = pollInterval;
      RandomizedDelaySec = "30s";
    };
  };
}
