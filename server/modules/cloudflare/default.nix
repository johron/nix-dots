{ config, pkgs, ... }: {
  # Keep pkgs.cloudflared installed system-wide
  environment.systemPackages = [ pkgs.cloudflared ];

  systemd.services.cloudflared-tunnel = {
    description = "Cloudflare Tunnel (Dashboard Managed)";
    after = [ "network.target" "network-online.target" ];
    wants = [ "network.target" "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      EnvironmentFile = "/var/lib/cloudflare/tunnel.env";
      ExecStart = "${pkgs.bash}/bin/bash -c '${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token \"$TUNNEL_TOKEN\"'";
      StandardOutput = "journal";
      StandardError = "journal";
      Restart = "on-failure";
      RestartSec = "5s";
      User = "root";
    };
  };
}
