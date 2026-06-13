{ config, pkgs, ... }:
let
  users = import ../../config/users.nix;
in
{
  imports = [
    ../../home/flavors/desktop/sway
    ../../home/flavors/application/workstation
    ../../home/flavors/application/development
  ];

  news.display = "silent";

  home = {
    username = users.default;
    homeDirectory = "/home/${users.default}";
    stateVersion = "26.05";
  };

  custom.swayExtras = {
    displays = ''
      output DP-2 pos 0 0 mode 1920x1080@143.981Hz
      output HDMI-A-1 mode 1920x1080@143.981Hz

      output * adaptive_sync off

      workspace 1 output DP-2
      workspace 2 output DP-2
      workspace 3 output DP-2

      workspace 11 output HDMI-A-1
      workspace 12 output HDMI-A-1
      workspace 13 output HDMI-A-1
      workspace 14 output HDMI-A-1
    '';
  };
}