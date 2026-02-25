{ pkgs, lib, ... }:
{
  imports = [
    ../../../features/application/sway
    ../../../features/application/mako.nix
    ../../../features/application/rofi.nix
    ../../../features/application/files.nix
    ../../../features/application/notwaita.nix
    ../../../features/application/alacritty.nix
    ../../../features/application/breeze-dark.nix
  ];
}