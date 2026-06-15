{ config, pkgs, lib, inputs, ... }:

let
  files = builtins.readDir ./config;
in
{
  imports = [
    ./bg

    ./theming/notwaita.nix
    ./theming/breeze-dark.nix
  ];

  config = {
    home.packages = [
      inputs.caelestia-shell.packages.${pkgs.system}.default
      inputs.caelestia-cli.packages.${pkgs.system}.default
    ];

    home.file.".config/hypr/hyprland.lua".source = ./config/hyprland.lua;
    home.file.".config/hypr/modules/autostart.lua".source = ./config/modules/autostart.lua; 
    home.file.".config/hypr/modules/environment.lua".source = ./config/modules/environment.lua; 
    home.file.".config/hypr/modules/look_and_feel.lua".source = ./config/modules/look_and_feel.lua; 
    home.file.".config/hypr/modules/misc.lua".source = ./config/modules/misc.lua; 
    home.file.".config/hypr/modules/input.lua".source = ./config/modules/input.lua; 
    home.file.".config/hypr/modules/keybindings.lua".source = ./config/modules/keybindings.lua; 
    home.file.".config/hypr/modules/windows_and_workspaces.lua".source = ./config/modules/windows_and_workspaces.lua; 
    home.file.".config/hypr/modules/monitors.lua".text = config.custom.hyprExtras.monitors;

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
  };
}