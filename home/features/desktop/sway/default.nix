{ config, pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
    ./scripts.nix

    ./bg
    ./ui/eww
    ./ui/wofi
    ./ui/waybar
    ./ui/mako.nix

    #./swayodroid

    ./theming/notwaita.nix
    ./theming/breeze-dark.nix
  ];

  config = {
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

    home.packages = with pkgs; [
      grim
      slurp
      swappy
    ];
  };

  options.custom.swayExtras = {
    displays = lib.mkOption {
      type = lib.types.lines;
      default = "";
      description = "Host-specific display configuration for Sway";
    };
  };
}