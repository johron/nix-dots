{ config, pkgs, lib, ... }:

let
  user = "johron";
  storageRoot = "/storage";

  folders = [
    "Applications"
    "Documents"
    "Downloads"
    "Games"
    "Machines"
    "Music"
    "Pictures"
    "Projects"
    "Scripts"
    "Videos"
    "Wineprefixes"
  ];

  mkBindMount = folder: {
    name = "/home/${user}/${folder}";
    value = {
      device = "${storageRoot}/${folder}";
      options = [ "bind" "nofail" "x-systemd.automount" ];
      depends = [ storageRoot ];
    };
  };
in
{
  imports = [
    ./networking.nix
    ./hardware-configuration.nix

    ../../nixos/hardware/gpu/nvidia.nix
    ../../nixos/hardware/wifi/bcm4360.nix
    ../../nixos/hardware/sound
    ../../nixos/flavors/desktop/sway
    ../../nixos/flavors/desktop/sway/greeter-default.nix
    ../../nixos/features/system/basic.nix
    ../../nixos/features/system/users.nix
    ../../nixos/features/system/gaming.nix
  ];

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  fileSystems = lib.mkMerge [
    (builtins.listToAttrs (map mkBindMount folders))
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  system.stateVersion = "25.11";
}