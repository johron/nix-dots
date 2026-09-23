{ config, pkgs, ... }:

let
  users = import ./../../../../config/users.nix;
in
{
  imports = [
    ./common.nix
  ];

  services.greetd = {
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --remember --user ${users.default} --time --cmd start-hyprland";
    };
  };
}