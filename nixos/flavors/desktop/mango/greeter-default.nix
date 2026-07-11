{ config, pkgs, ... }:


let
  users = import ./../../../../config/users.nix;
in
{
  environment.systemPackages = with pkgs; [
    tuigreet
  ];

  security.pam.services.greetd.enableGnomeKeyring = true;
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = ''
        ${pkgs.tuigreet}/bin/tuigreet --time --cmd "mango"
      '';
      user = users.default;
    };
  };
}