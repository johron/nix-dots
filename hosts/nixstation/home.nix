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

  custom.hyprExtras = {
    monitors = ''
      hl.monitor({ output = "DP-2", mode = "1920x1080@143.98", position = "0x0", scale = 1 })
      hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@143.98", position = "1920x0", scale = 1 })

      -- fallback:
      hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

      -- rules
      for i = 1, 10 do
        hl.workspace_rule({ workspace = i % 10, monitor = "DP-2", default = true })
      end

      for i = 11, 20 do
        hl.workspace_rule({ workspace = i, monitor = "HDMI-A-1", default = true })
      end

      hl.config({
          cursor = {
              default_monitor = "DP-2"
          }
      })
    '';
  };
}