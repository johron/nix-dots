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

    ../../../nixos/modules/hardware/graphics/nvidia.nix
    ../../../nixos/modules/hardware/networking/bcm4360.nix
    ../../../nixos/modules/hardware/sound
    ../../../nixos/modules/hardware/bluetooth

    ../../../nixos/modules/desktop/hyprland
    ../../../nixos/modules/desktop/hyprland/greeter-default.nix
  ];
  
  boot.kernelParams = [
    "resume=UUID=ba1f1991-b3cf-4bb3-8558-da54c9afa148"
  ];

  networking.hostName = hosts.nixstation.hostname;
}
