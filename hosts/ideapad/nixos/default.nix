{ config, pkgs, lib, ... }:

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

    ../../../nixos/modules/hardware/networking
    ../../../nixos/modules/hardware/sound
    ../../../nixos/modules/hardware/bluetooth
    ../../../nixos/modules/hardware/biometric/elan-fingerprint.nix

    ../../../nixos/modules/desktop/hyprland
    ../../../nixos/modules/desktop/hyprland/greeter-default.nix

  ];

  boot.kernelParams = [
    "resume=UUID=3f914128-2e08-4080-b1bb-d7ddf9ef647a"
  ];

  networking.hostName = hosts.ideapad.hostname;

  virtualisation = {
    docker = {
      storageDriver = "overlay2";
    };
  };
}
