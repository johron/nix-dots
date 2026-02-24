{ pkgs, lib, ... }:
{
  imports = [

  ];

  environment.systemPackages = with pkgs; [
    lutris
    prismlauncher
  ];

  programs.steam.enable = true;
}