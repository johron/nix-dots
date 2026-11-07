{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  environment.systemPackages = [
    pkgs.sops
  ];

  sops = {
    defaultSopsFile = ./secrets.enc.yaml;
    age.keyFile = "/opt/sops/age/keys.txt";
  };
}