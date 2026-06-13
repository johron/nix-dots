{ pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
    ./scripts.nix

    ./bg
    ./ui/eww
    ./ui/wofi
    ./ui/waybar
    ./ui/mako.nix
    
    ./theming/notwaita.nix
    ./theming/breeze-dark.nix
  ];

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
}