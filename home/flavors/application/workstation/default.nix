{ pkgs, lib, ... }:
{
  imports = [
    ../../../features/application/helix.nix
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
    dotnetCorePackages.sdk_9_0-bin
  ];
}