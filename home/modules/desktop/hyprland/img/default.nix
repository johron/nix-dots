{ pkgs, lib, config, ... }:

{
  home = {
    file = {
      "Pictures/shell-imgs/bg.png".source = ./reef.png;
      "Pictures/shell-imgs/tux-fly.gif".source = ./tux-fly.gif;
      "Pictures/shell-imgs/tux-race.gif".source = ./tux-race.gif;
    };
  };
}