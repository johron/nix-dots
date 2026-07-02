{ config, pkgs, lib, ... }:

let 
  hosts = import ../../config/hosts.nix;
in
{
  imports = [
    ./hardware.nix

    ../../nixos/hardware/networking
    ../../nixos/hardware/gpu/nvidia.nix
    ../../nixos/hardware/sound
    ../../nixos/hardware/bluetooth
    ../../nixos/flavors/desktop/hyprland
    ../../nixos/flavors/desktop/hyprland/greeter-default.nix
    ../../nixos/flavors/application/workstation
    ../../nixos/flavors/application/development
    ../../nixos/flavors/application/gaming
    ../../nixos/flavors/application/school
  ];

  boot.kernelParams = [
    "resume=UUID=b0e53493-71b7-4adc-bc9a-37c16ed9672b"
  ];

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = hosts.dellaptop.hostname;

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
