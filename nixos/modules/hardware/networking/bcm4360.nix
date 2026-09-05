{ config, lib, pkgs, ... }:
{
  imports = [
    ./default.nix
  ];

  boot.kernelModules = [ "wl" ];

  boot.blacklistedKernelModules = [ "b43" "bcma" "brcmfmac" ];
  boot.extraModulePackages = with config.boot.kernelPackages; [ broadcom_sta ];

  nixpkgs.config.allowInsecurePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "broadcom-sta"
    ];
}