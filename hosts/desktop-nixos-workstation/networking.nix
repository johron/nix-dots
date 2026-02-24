{ config, pkgs, ... }:
let
  hosts = import ../../config/hosts.nix;
in

{
  networking.hostName = hosts.nixstation.hostname;
}