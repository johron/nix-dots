{ pkgs, ... }:
{
  hardware.bluetooth.enable = true;
  services.blueman.enable = true;

  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=0
  '';
}