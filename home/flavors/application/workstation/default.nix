{ pkgs, lib, ... }:
{
  imports = [
    ../../../features/application/helix.nix
  ];

  home.packages = with pkgs; [
    spotify
    feishin
    kdePackages.kdenlive
    kdePackages.ark
    kdePackages.dolphin
    obsidian
    vlc
    inkscape
    f3d
    geogebra6
    chromium
    mediawriter
    tailscale
  ];
}