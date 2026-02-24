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

  users.users.${users.default} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "video" "audio" "input" "networkmanager" "seat" "libvirtd" "docker" ];
  };
}