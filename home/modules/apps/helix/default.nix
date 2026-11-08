{ config, pkgs, lib, ... }:

let
  noArrows = {
    up = "no_op";
    down = "no_op";
    left = "no_op";
    right = "no_op";
  };

  jklo_normal = {
    j = "move_char_left";
    l = "move_visual_line_up";
    k = "move_visual_line_down";
    "ø" = "move_char_right";
  };

  jklo_select = {
    j = "extend_char_left";
    l = "extend_visual_line_up";
    k = "extend_visual_line_down";
    "ø" = "extend_char_right";
  };
in
{
  programs.helix = {
    enable = true;
    settings = {
      theme = "autumn_night_transparent";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
      keys = {
        normal = noArrows // jklo_normal // { h = "no_op"; };
        select = noArrows // jklo_select // { h = "no_op"; };
        insert = noArrows;
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = lib.getExe pkgs.nixfmt;
    }];
    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };
}