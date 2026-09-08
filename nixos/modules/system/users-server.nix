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

  users.users.${users.vaktmester} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "docker" ];
  };

  users.defaultUserShell = pkgs.fish;
}