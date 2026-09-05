{ pkgs, lib, ... }:

{
  home = {
    file = {
      ".config/sway/bg/reef.png".source = ./reef.png;
      ".config/sway/bg/reef-2.png".source = ./reef-2.png;
    };
  };
}