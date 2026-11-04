{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../home/modules/system/home-base.nix
    ../../../home/modules/apps/fish
  ];
}