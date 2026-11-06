{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    ../../modules/secrets/sops.nix
  ];

  boot.kernelPackages = pkgs.linuxPackages;

  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  hardware.enableRedistributableFirmware = true;
  services.fwupd.enable = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "26.05";
}