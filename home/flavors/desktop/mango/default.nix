{ pkgs, lib, ... }:
{
  imports = [
    ../../../features/desktop/mango
    ../../../features/application/bashrc.nix
    ../../../features/application/alacritty.nix
  ];
}