{ config, pkgs, ... }:

{
  services.fprintd = {
    tod.enable = true;
    tod.driver = pkgs.libfprint-2-tod1-elan;
  };

  security.pam.services.polkit-1.fprintAuth = true;
}
