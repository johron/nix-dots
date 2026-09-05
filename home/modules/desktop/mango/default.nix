{ config, pkgs, lib, inputs, ... }:
{
  #wayland.windowManager.mango = {
  #  enable = true;
  #};

  options.custom.hyprExtras = {
    monitors = lib.mkOption {
      type = lib.types.lines;
      default = ''
        hl.monitor({ output = "", mode = "preferred", position = "auto", scale = 1 })
      '';
      description = "Host-specific monitor configuration for Hyprland";
    };
    shell = lib.mkOption {
      type = lib.types.lines;
      default = '''';
    };
  };
}
