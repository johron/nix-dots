{ config, pkgs, ... }:

{
  environment.systemPackages = [ pkgs.cloudflared ];

  sops.secrets."cloudflare/tunnel_token" = { };
  sops.templates."cloudflare-tunnel.env".content = ''
    TUNNEL_TOKEN=${config.sops.placeholder."cloudflare/tunnel_token"}
  '';

  systemd.services.cloudflared-tunnel = {
    description = "Cloudflare Tunnel (Dashboard Managed)";
    after = [ "network.target" "network-online.target" ];
    wants = [ "network.target" "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      EnvironmentFile = config.sops.templates."cloudflare-tunnel.env".path;
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token \"$TUNNEL_TOKEN\"'";
      StandardOutput = "journal";
      StandardError = "journal";
      Restart = "on-failure";
      RestartSec = "5s";
      User = "root";
    };
  };
}
