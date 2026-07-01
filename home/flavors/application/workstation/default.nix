{ pkgs, lib, ... }:
{
  imports = [
    ../../../features/application/helix.nix
  ];

  home.packages = with pkgs; [
    spotify
    feishin
    aonsoku
    kdePackages.kdenlive
    kdePackages.ark
    kdePackages.dolphin
    obsidian
    vlc
    inkscape
    f3d
    chromium
    mediawriter
    tailscale
  ];
}