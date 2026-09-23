{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  services.greetd = {
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --remember --user ${users.default} --cmd mango";
    };
  };
}