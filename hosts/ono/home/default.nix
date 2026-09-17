{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../home/modules/system/home-base.nix

    ../../../home/modules/desktop/hyprland
    ./hyprland.nix

    ../../../home/modules/configs/alacritty.nix
    ../../../home/modules/configs/fish
  ];
}