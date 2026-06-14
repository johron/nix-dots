{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ./bg

    ./theming/notwaita.nix
    ./theming/breeze-dark.nix
  ];

  home.packages = [
    inputs.caelestia-shell.packages.${pkgs.system}.default
    inputs.caelestia-cli.packages.${pkgs.system}.default
  ];

  home.file.".config/hypr".source = ./config;

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
}