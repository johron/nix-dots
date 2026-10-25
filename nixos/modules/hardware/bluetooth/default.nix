{ pkgs, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
        AutoConnect = true;
        FastConnectable = true; 
      };
    };
  };
  services.blueman.enable = true;

  boot.extraModprobeConfig = ''
    options btusb enable_autosuspend=0
  '';
}