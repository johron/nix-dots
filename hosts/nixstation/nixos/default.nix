{ config, pkgs, lib, inputs, ... }:

let 
  hosts = import ../../../config/hosts.nix;
in
{
  imports = [
    ./hardware.nix

    ../../../nixos/modules/system/nixos-base.nix
    ../../../nixos/modules/system/users.nix

    ../../../nixos/profiles/workstation
    ../../../nixos/profiles/development
    ../../../nixos/profiles/gaming
    ../../../nixos/profiles/school

    ../../../nixos/modules/hardware/gpu/nvidia.nix
    ../../../nixos/modules/hardware/networking/bcm4360.nix
    ../../../nixos/modules/hardware/sound
    ../../../nixos/modules/hardware/bluetooth

    ../../../nixos/modules/desktop/hyprland
    ../../../nixos/modules/desktop/hyprland/greeter-default.nix
  ];
  
  networking.hostName = hosts.nixstation.hostname;
}
