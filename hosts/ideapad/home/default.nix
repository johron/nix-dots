{ config, pkgs, lib, ... }:
let
  users = import ../../../config/users.nix;
in
{
  imports = [
    ../../../home/modules/system/home-base.nix

    ../../../home/modules/desktop/hyprland
    ../../../home/modules/shells/dms-shell
  ];

  news.display = "silent";

  home = {
    username = users.default;
    homeDirectory = "/home/${users.default}";
    stateVersion = "26.05";
  };
}