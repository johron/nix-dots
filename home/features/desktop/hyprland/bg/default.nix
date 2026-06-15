{ pkgs, lib, ... }:

{
  home = {
    file = {
      ".config/hypr/bg.png".source = ./reef.png;
    };
  };
}