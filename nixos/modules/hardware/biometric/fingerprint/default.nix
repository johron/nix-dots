{ config, pkgs, ... }:

{
  services.fprintd = {
      enable = true;
  };

  security.pam.services = {
      sudo.fprintAuth = true;
      login.fprintAuth = true;
      polkit-1.fprintAuth = true;
  };
}
