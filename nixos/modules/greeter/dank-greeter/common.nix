{ config, pkgs, inputs, ... }:

let
  users = import ./../../../../config/users.nix;
in
{
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services."dankshell-u2f".text = ''
    auth     required ${pkgs.pam_u2f}/lib/security/pam_u2f.so cue
    account  required pam_permit.so
  '';

  programs.dms-greeter = {
    enable = true;
    configHome = "/home/${users.default}";
  };
}