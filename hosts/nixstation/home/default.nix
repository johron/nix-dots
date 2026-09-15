{ config, pkgs, ... }:

{
  imports = [
    ../../../home/modules/system/home-base.nix

    ../../../home/modules/desktop/mango
    #../../../home/modules/shells/dms-shell

    ../../../home/modules/configs/alacritty.nix
    ../../../home/modules/configs/fish
  ];
}