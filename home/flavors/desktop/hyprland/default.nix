{ pkgs, lib, ... }:
{
  imports = [
    ../../../features/desktop/hyprland
    ../../../features/application/bashrc.nix
    ../../../features/application/alacritty.nix
  ];
}