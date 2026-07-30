{ config, pkgs, lib, ... }:
let
  users = import ../../config/users.nix;
in
{
  imports = [
    ../../home/flavors/desktop/hyprland
  ];

  news.display = "silent";

  home = {
    username = users.default;
    homeDirectory = "/home/${users.default}";
    stateVersion = "26.05";
  };
}