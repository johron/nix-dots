{ config, pkgs, inputs, ... }:

let
  users = import ./../../../../config/users.nix;
in
{
  imports = [
    inputs.dms.nixosModules.greeter
  ];

  environment.systemPackages = with pkgs; [
    #tuigreet
  ];

  security.pam.services.greetd.enableGnomeKeyring = true;
  services.displayManager.dms-greeter = {
    enable = true;
    compositor.name = "hyprland";
    configHome = "/home/${users.default}";
  };

  #services.greetd = {
  #  enable = true;
  #  settings.default_session = {
  #    command = ''
  #      ${pkgs.tuigreet}/bin/tuigreet --time --cmd "start-hyprland"
  #    '';
  #    user = users.default;
  #  };
  #};
}