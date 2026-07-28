{ pkgs, inputs, ... }:

{
  environment.systemPackages = [
    inputs.vm-curator.packages.${pkgs.system}.default
  ];
}