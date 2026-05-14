{ config, pkgs, lib, ... }:

{
  imports = [
    ./networking.nix
    ./hardware-configuration.nix

    ../../nixos/hardware/gpu/nvidia.nix
    ../../nixos/hardware/wifi/bcm4360.nix
    ../../nixos/hardware/sound
    ../../nixos/hardware/bluetooth
    ../../nixos/flavors/desktop/sway
    ../../nixos/flavors/desktop/sway/greeter-default.nix
    ../../nixos/features/system/basic.nix
    ../../nixos/features/system/users.nix
    ../../nixos/features/system/gaming.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "25.11";
}
