{ config, pkgs, ... }:

{
  imports = [
    ./default.nix
  ];

  services.fprintd = {
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-elan;
  };
}
