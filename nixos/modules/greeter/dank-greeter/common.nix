{ config, pkgs, inputs, ... }:

let
  users = import ./../../../../config/users.nix;
in
{
  services.displayManager.dms-greeter = {
    configHome = "/home/${users.default}";
    configFiles = [
      "/home/${users.default}/.config/DankMaterialShell/settings.json"
    ];

    logs = {
      save = true; 
      path = "/tmp/dms-greeter.log";
    };
  };
}