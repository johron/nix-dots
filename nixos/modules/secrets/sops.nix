{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = [
    pkgs.sops
  ];

  environment.variables = {
    SOPS_AGE_KEY_FILE = "/opt/sops/age/keys.txt";
  };

  sops = {
    defaultSopsFile = ../../../secrets.yaml;
    age.keyFile = "/opt/sops/age/keys.txt";
  };
}