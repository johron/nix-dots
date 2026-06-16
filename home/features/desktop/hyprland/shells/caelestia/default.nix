{ config, pkgs, lib, inputs, ... }:

{
  home.packages = [
    inputs.caelestia-shell.packages.${pkgs.system}.default
    inputs.caelestia-cli.packages.${pkgs.system}.default
  ];

  home.file.".config/caelestia/shell.json".source = ./shell.json;
  home.file.".config/caelestia/shell-tokens.json".source = ./shell-tokens.json;
}