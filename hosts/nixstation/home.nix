{ config, pkgs, ... }:
let
  users = import ../../config/users.nix;
in
{
  imports = [
    ../../home/flavors/desktop/hyprland
    ../../home/flavors/application/workstation
    ../../home/flavors/application/development
  ];

  news.display = "silent";

  home = {
    username = users.default;
    homeDirectory = "/home/${users.default}";
    stateVersion = "26.05";
  };

  #custom.swayExtras = {
  #  displays = ''
  #    output DP-2 pos 0 0 mode 1920x1080@143.981Hz
  #    output HDMI-A-1 mode 1920x1080@143.981Hz
#
  #    output * adaptive_sync off
#
  #    workspace 1 output DP-2
  #    workspace 2 output DP-2
  #    workspace 3 output DP-2
#
  #    workspace 11 output HDMI-A-1
  #    workspace 12 output HDMI-A-1
  #    workspace 13 output HDMI-A-1
  #    workspace 14 output HDMI-A-1
  #  '';
  #};

  custom.hyprExtras = {
    monitors = ''
      hl.monitor({ output = "DP-2", mode = "1920x1080@143.98", position = "0x0", scale = 1 })
      hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@143.98", position = "1920x0", scale = 1 })

      -- fallback:
      hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

      -- rules
      hl.workspace_rule({ workspace = "1", monitor = "DP-2", default = true })
      hl.config({
          cursor = {
              default_monitor = "DP-2"
          }
      })
    '';
  };
}