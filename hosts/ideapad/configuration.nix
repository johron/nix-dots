{ config, pkgs, lib, ... }:

let 
  hosts = import ../../config/hosts.nix;
in
{
  imports = [
    ./hardware.nix

    ../../nixos/hardware/networking
    ../../nixos/hardware/sound
    ../../nixos/hardware/bluetooth
    ../../nixos/hardware/biometric/elan-fingerprint.nix
    ../../nixos/flavors/desktop/hyprland
    ../../nixos/flavors/desktop/hyprland/greeter-default.nix
    ../../nixos/flavors/application/workstation
    ../../nixos/flavors/application/development
    ../../nixos/flavors/application/gaming
    ../../nixos/flavors/application/school
    ../../nixos/features/system/users.nix
  ];

  boot.kernelParams = [
    "resume=UUID=3f914128-2e08-4080-b1bb-d7ddf9ef647a"
  ];

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = hosts.ideapad.hostname;

  hardware.nvidia = {
    powerManagement = {
      enable = true;
      finegrained = true;
    };

    prime = {
      offload = {
        enable = true;
        enableOffloadCmd = true;
      };

      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:2:0:0";
    };
  };

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "26.05";
}
