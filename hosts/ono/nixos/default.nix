{ config, pkgs, lib, ... }:

let 
  hosts = import ../../../config/hosts.nix;
  biopass = pkgs.callPackage ../../../nixos/programs/biopass.nix {};
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
    ../../../nixos/modules/hardware/biometric/fingerprint
    ../../../nixos/modules/hardware/power/battery.nix

    ../../../nixos/modules/desktop/hyprland
    ../../../nixos/modules/greeter/tuigreet/hyprland.nix
  ];

  #boot.kernelParams = [
  #  "resume=UUID=3f914128-2e08-4080-b1bb-d7ddf9ef647a"
  #];

  boot.kernelParams = [
    "amd_pstate=active"
  ];

  networking.hostName = hosts.ono.hostname;
}
