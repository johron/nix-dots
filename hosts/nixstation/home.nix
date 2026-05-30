{ config, pkgs, ... }:
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

}