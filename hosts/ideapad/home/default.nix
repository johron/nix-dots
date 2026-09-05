{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../home/modules/system/home-base.nix

    ../../../home/modules/desktop/hyprland
    ../../../home/modules/shells/dms-shell

    ../../../home/modules/configs/alacritty.nix
    ../../../home/modules/configs/fish.nix
  ];
}