{ config, pkgs, lib, inputs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "26.05";
}