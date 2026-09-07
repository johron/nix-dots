{ config, pkgs, inputs, ... }:

{
  imports = [
    ./common.nix
  ];
  
  services.displayManager.dms-greeter = {
    compositor.name = "hyprland";
  };
}