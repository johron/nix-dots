{ pkgs, lib, ... }:

{
  home = {
    file = {
      ".config/caelestia/img/bg.png".source = ./reef.png;
      ".config/caelestia/img/tux-fly.gif".source = ./tux-fly.gif;
      ".config/caelestia/img/tux-race.gif".source = ./tux-race.gif;
    };
  };
}