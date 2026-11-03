{ config, pkgs, ... }: {
  # Install the cloudflared package system-wide (optional, for CLI tools)
  environment.systemPackages = [ pkgs.cloudflared ];

  # Define the custom systemd service for the dashboard tunnel
  systemd.services.cloudflared-tunnel = {
    description = "Cloudflare Tunnel (Dashboard Managed)";
    after = [ "network.target" "network-online.target" ];
    wants = [ "network.target" "network-online.target" ];
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      # Load the token variable securely at runtime
      EnvironmentFile = "/var/lib/cloudflared/tunnel.env";
      
      # Execute the tunnel run command, pulling the token from the environment
      ExecStart = "${pkgs.cloudflared}/bin/cloudflared tunnel --no-autoupdate run --token \${TUNNEL_TOKEN}";
      
      Restart = "on-failure";
      RestartSec = "5s";
      
      # Run as root to allow reading the secure environment file
      User = "root";
    };
  };
}
