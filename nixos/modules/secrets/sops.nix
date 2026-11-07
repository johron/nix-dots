{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = [
    pkgs.sops
  ];

  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    age.keyFile = "~/sops/age/keys.txt";
  };
}