{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../home/modules/system/home-base.nix

    #../../../home/modules/desktop/mango
    ../../../home/modules/desktop/hyprland
    ./hyprland.nix

    ../../../home/modules/apps/alacritty.nix
    ../../../home/modules/apps/fish
  ];
}