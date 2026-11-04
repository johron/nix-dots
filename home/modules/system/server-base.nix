{ config, pkgs, ... }:

let
  users = import ../../../config/users.nix;
in
{
  news.display = "silent";

  home = {
    username = users.janitor;
    homeDirectory = "/home/${users.janitor}";
    stateVersion = "26.05";
  };
}