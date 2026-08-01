{ config, pkgs, ... }:

{
    services.fprintd = {
        enable = true;
        tod.enable = true;
        tod.driver = pkgs.libfprint-2-tod1-elan;
    };

    security.pam.services = {
        sudo.fprintAuth = true;
        polkit-1.fprintAuth = true;
    };
}
