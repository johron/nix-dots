{ config, pkgs, ... }:

{
  imports = [
    ../../../home/modules/system/home-base.nix

    ../../../home/modules/desktop/hyprland
    ./hyprland.nix

    ../../../home/modules/apps/alacritty.nix
    ../../../home/modules/apps/firefox.nix
    ../../../home/modules/apps/fish
    ../../../home/modules/apps/emacs
    ../../../home/modules/apps/neovim
  ];
}