{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./img
    ./shells/dankmaterialshell
    ./theming/notwaita.nix
    ./theming/breeze-dark.nix
  ];

  config = {
    home.file.".config/hypr/hyprland.lua".source = ./hypr/hyprland.lua;
    home.file.".config/hypr/modules/autostart.lua".source = ./hypr/modules/autostart.lua; 
    home.file.".config/hypr/modules/environment.lua".source = ./hypr/modules/environment.lua; 
    home.file.".config/hypr/modules/look_and_feel.lua".source = ./hypr/modules/look_and_feel.lua; 
    home.file.".config/hypr/modules/misc.lua".source = ./hypr/modules/misc.lua; 
    home.file.".config/hypr/modules/input.lua".source = ./hypr/modules/input.lua; 
    home.file.".config/hypr/modules/keybindings.lua".source = ./hypr/modules/keybindings.lua; 
    home.file.".config/hypr/modules/windows_and_workspaces.lua".source = ./hypr/modules/windows_and_workspaces.lua; 
    home.file.".config/hypr/modules/monitors.lua".text = config.custom.hyprExtras.monitors;
    home.file.".config/hypr/modules/shell.lua".text = config.custom.hyprExtras.shell;

    xdg.userDirs = {
      enable = true;
      createDirectories = true;
      
      documents = "$HOME/Documents";
      download = "$HOME/Downloads";
      desktop = "$HOME/Desktop";
      music = "$HOME/Music";
      pictures = "$HOME/Pictures";
      videos = "$HOME/Videos";
      projects = "$HOME/Projects";
    };
  };

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