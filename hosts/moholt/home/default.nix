{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../home/modules/system/server-base.nix

    ../../../home/modules/secrets/sops.nix
    ../../../home/modules/ssh

    ../../../home/modules/apps/fish
  ];
}