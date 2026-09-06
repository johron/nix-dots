{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.dank-greeter.nixosModules.default
    ./common.nix
  ];
  
  programs.dms-greeter = {
    compositor.name = "hyprland";
  };
}