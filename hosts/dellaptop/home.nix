{ config, pkgs, lib, ... }:
let
  users = import ../../config/users.nix;
in
{
  imports = [
    ../../home/flavors/desktop/sway
    ../../home/flavors/application/workstation
    ../../home/flavors/application/development
  ];

  news.display = "silent";

  home = {
    username = users.default;
    homeDirectory = "/home/${users.default}";
    stateVersion = "26.05";
  };

  custom.swayExtras = {
    displays = ''
      output eDP-1 pos 0 0 mode 1920x1080@59.999Hz
      output * pos 1920 0 adaptive_sync off

      workspace 1 output eDP-1
    '';
  };
}