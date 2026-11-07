{ config, pkgs, lib, ... }:

let
  authorizedKeys = pkgs.writeText "authorized_keys" (
    lib.concatStringsSep "\n" [
      config.home.file.".ssh/keys/moholt-janitor.pub".text
    ]
  );
in
{
  imports = [
    ../../../home/modules/system/server-base.nix

    ../../../home/modules/secrets/sops.nix
    ../../../home/modules/ssh

    ../../../home/modules/apps/fish
  ];

  home.activation.installAuthorizedKeys = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    run mkdir -p "$HOME/.ssh"
    run chmod 700 "$HOME/.ssh"
    # Remove any leftover symlink, then write a real file
    run rm -f "$HOME/.ssh/authorized_keys"
    run ${pkgs.coreutils}/bin/install -m 600 ${authorizedKeys} "$HOME/.ssh/authorized_keys"
  '';
}