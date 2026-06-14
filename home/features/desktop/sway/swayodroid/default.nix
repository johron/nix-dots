{ config, pkgs, lib, ... }:

{
  home.packages = with pkgs; [
    qt6.qtwayland
    #qt6.qtsvg
    #qt6.qtimageformats
    #qt6.qtmultimedia
    #qt6.qt5compat
  ];

  programs.quickshell = {
    enable = true;

    configs.swayodroid = ./swayodroid-shell;
    activeConfig = "swayodroid";
  };
}