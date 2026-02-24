{ pkgs, ... }:
{
  imports = [
    ./kdeconnect.nix
  ];

  hardware.bluetooth.enable = true;
  services.blueman.enable = true;
}