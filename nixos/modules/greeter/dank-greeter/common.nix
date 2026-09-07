{ config, pkgs, inputs, ... }:

let
  users = import ./../../../../config/users.nix;
in
{
  services.displayManager.dms-greeter = {
    enable = true;

    configHome = "/home/${users.default}";
    configFiles = [
      "/home/${users.default}/.config/DankMaterialShell/settings.json"
    ];

    logs = {
      save = true; 
      path = "/tmp/dms-greeter.log";
    };
  };

  security.pam.services.greetd = {
    fprintAuth = true;
    u2fAuth = true;
  };
}