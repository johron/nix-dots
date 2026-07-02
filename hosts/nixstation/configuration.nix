{ config, pkgs, lib, ... }:

let 
  hosts = import ../../config/hosts.nix;
in
{
  imports = [
    ./hardware.nix

    ../../nixos/hardware/gpu/nvidia.nix
    ../../nixos/hardware/networking/bcm4360.nix
    ../../nixos/hardware/sound
    ../../nixos/hardware/bluetooth
    ../../nixos/flavors/desktop/hyprland
    ../../nixos/flavors/desktop/hyprland/greeter-default.nix
    ../../nixos/flavors/application/workstation
    ../../nixos/flavors/application/development
    ../../nixos/flavors/application/gaming
    ../../nixos/flavors/application/school
    ../../nixos/features/system/users.nix
  ];

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = hosts.nixstation.hostname;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "26.05";
}
