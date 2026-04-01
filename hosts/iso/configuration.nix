{ config, pkgs, lib, ... }:

{
  imports = [
    ./networking.nix

    #../../nixos/hardware/gpu/nvidia.nix
    ../../nixos/hardware/wifi/bcm4360.nix
  ];

  nixpkgs.config.allowUnfree = true;

  networking.hostName = "iso";
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;

  hardware.graphics = enable;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  fileSystems = lib.mkMerge [
    (builtins.listToAttrs (map mkBindMount folders))
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "25.11";  
}