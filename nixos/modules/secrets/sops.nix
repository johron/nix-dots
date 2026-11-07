{ config, pkgs, lib, inputs, host, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = [
    pkgs.sops
  ];

  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    age.keyFile = "${config.users.users.${host.user}.home}/.config/sops/age/keys.txt";
  };
}