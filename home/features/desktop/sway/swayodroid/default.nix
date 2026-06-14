{ config, pkgs, inputs, ... }:

{
  imports = [
    inputs.swayodroid.homeManagerModules.default
  ];
}