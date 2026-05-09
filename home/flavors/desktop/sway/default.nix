{ pkgs, lib, ... }:
{
  imports = [
    ../../../features/desktop/sway
    ../../../features/application/bashrc.nix
    ../../../features/application/alacritty.nix
  ];
}