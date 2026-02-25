{ pkgs, lib, ... }:
{
  imports = [

  ];

  home.packages = with pkgs; [
    spotify
    discord
    feishin
    kdePackages.kdenlive
    kdePackages.ark
    kdePackages.dolphin
    obsidian
    vlc
    inkscape
    f3d
    geogebra6
  ];
}