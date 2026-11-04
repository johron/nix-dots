{ config, pkgs, ... }:

let
  users = import ../../../config/users.nix;
in
{
  news.display = "silent";

  home = {
    username = users.default;
    homeDirectory = "/home/${users.default}";
    stateVersion = "26.05";
  };
}