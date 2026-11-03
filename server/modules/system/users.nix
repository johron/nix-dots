{ config, pkgs, ... }:

let
  users = import ../../../config/users.nix;
in
{
  security = {
    sudo = {
      wheelNeedsPassword = true;
    };
  };

  users.users.${users.server} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" ];
  };

  users.defaultUserShell = pkgs.fish;
}