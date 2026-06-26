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
    ../../nixos/features/system/basic.nix
    ../../nixos/features/system/users.nix
    ../../nixos/features/system/gaming.nix
  ];

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  networking.hostName = hosts.nixstation.hostname;

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "26.05";

  nixpkgs.overlays = [
    (final: prev: {
      openblas = prev.openblas.overrideAttrs (old: { doCheck = false; });
    })
  ];
}
