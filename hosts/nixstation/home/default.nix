{ config, pkgs, ... }:

{
  imports = [
    ../../../home/modules/system/home-base.nix

    ../../../home/modules/desktop/hyprland
    ../../../home/modules/shells/dms-shell

    ../../../home/modules/configs/alacritty.nix
    ../../../home/modules/configs/fish.nix
  ];

  custom.hyprExtras = {
    monitors = ''
      hl.monitor({ output = "DP-1", mode = "1920x1080@143.98", position = "0x0", scale = 1 })
      hl.monitor({ output = "HDMI-A-1", mode = "1920x1080@143.98", position = "1920x0", scale = 1 })

      -- fallback:
      hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })

      -- rules
      for i = 1, 10 do
        hl.workspace_rule({ workspace = i % 10, monitor = "DP-1", default = true })
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