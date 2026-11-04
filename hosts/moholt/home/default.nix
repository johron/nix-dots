{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../home/modules/system/server-base.nix
    ../../../home/modules/apps/fish
  ];
}