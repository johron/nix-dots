{ config, pkgs, ... }:

{
  imports = [
    ./common.nix
  ];

  services.greetd = {
    settings.default_session = {
      command = "${pkgs.greetd.tuigreet}/bin/tuigreet --cmd mango";
    };
  };
}