{ config, pkgs, ... }:

{
  services.cloudflared = {
    enable = true;
    tokenFile = "/var/lib/cloudflared/tunnel-token";
  };
}