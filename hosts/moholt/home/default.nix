{ config, pkgs, lib, ... }:

{
  imports = [
    ../../../home/modules/system/server-base.nix

    ../../../home/modules/secrets/sops.nix
    ../../../home/modules/ssh

    ../../../home/modules/apps/fish
  ];

  home.file.".ssh/authorized_keys" = {
    text = lib.concatStringsSep "\n" [
      config.home.file.".ssh/keys/moholt-janitor.pub".text
    ];
    onChange = "chmod 600 ~/.ssh/authorized_keys"; 
  };
}