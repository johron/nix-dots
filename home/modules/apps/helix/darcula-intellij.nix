{ config, pkgs, ... }:

{
  programs.helix.themes = {
    darcula_intellij = {
      palette = {
        panel = "#12100e";
        panel_alt = "#0E0D0C";
        line = "#1f1f1f";
        sel = "#2a3550";
        menu_sel = "#33425f";

        fg = "#A9B7C6";
        fg_dim = "#5a5d60";
        comment = "#808080";
        orange = "#CC7832";
        yellow = "#FFC66D";
        annot = "#BBB529";
        green = "#6A8759";
        green_d = "#629755";
        blue = "#6897BB";
        purple = "#9876AA";
        teal = "#4EC9B0";
        red = "#FF6B68";
        red_d = "#BC3F3C";
        warn = "#F2C55C";
      };

      "ui.background" = { };
      "ui.text" = {
        fg = "fg";
      };
      "ui.text.focus" = {
        fg = "#FFFFFF";
        bg = "menu_sel";
      };
      "ui.text.info" = {
        fg = "fg";
        bg = "panel";
      };

      "ui.gutter" = { };
      "ui.linenr" = {
        fg = "fg_dim";
      };
      "ui.linenr.selected" = {
        fg = "fg";
      };

      "ui.selection" = {
        bg = "sel";
      };
      "ui.selection.primary" = {
        bg = "sel";
      };
      "ui.cursorline.primary" = {
        bg = "panel_alt";
      };
      "ui.cursorline.secondary" = {
        bg = "panel";
      };
      "ui.cursor" = {
        modifiers = [ "reversed" ];
      };
      "ui.cursor.primary" = {
        modifiers = [ "reversed" ];
      };
      "ui.cursor.match" = {
        fg = "yellow";
        modifiers = [
          "bold"
          "underlined"
        ];
      };

      "ui.virtual.whitespace" = {
        fg = "#333333";
      };
      "ui.virtual.indent-guide" = {
        fg = "#2a2a2a";
      };
      "ui.virtual.ruler" = {
        bg = "line";
      };
      "ui.virtual.inlay-hint" = {
        fg = "fg_dim";
      };
      "ui.virtual.wrap" = {
        fg = "fg_dim";
      };

      "ui.statusline" = {
        fg = "fg";
        bg = "panel";
      };
      "ui.statusline.inactive" = {
        fg = "fg_dim";
        bg = "panel_alt";
      };
      "ui.statusline.normal" = {
        fg = "blue";
        bg = "panel";
        modifiers = [ "bold" ];
      };
      "ui.statusline.insert" = {
        fg = "green";
        bg = "panel";
        modifiers = [ "bold" ];
      };
      "ui.statusline.select" = {
        fg = "orange";
        bg = "panel";
        modifiers = [ "bold" ];
      };

      "ui.menu" = {
        fg = "fg";
        bg = "panel";
      };
      "ui.menu.selected" = {
        fg = "#FFFFFF";
        bg = "menu_sel";
      };
      "ui.menu.scroll" = {
        fg = "fg_dim";
        bg = "panel";
      };
      "ui.popup" = {
        fg = "fg";
        bg = "panel";
      };
      "ui.popup.info" = {
        fg = "fg";
        bg = "panel";
      };
      "ui.help" = {
        fg = "fg";
        bg = "panel";
      };
      "ui.window" = {
        fg = "#2a2a2a";
      };

      "ui.bufferline" = {
        fg = "fg_dim";
        bg = "panel_alt";
      };
      "ui.bufferline.active" = {
        fg = "fg";
        bg = "panel";
        modifiers = [ "bold" ];
      };
      "ui.bufferline.background" = {
        bg = "panel_alt";
      };

      "comment" = {
        fg = "comment";
        modifiers = [ "italic" ];
      };
      "keyword" = {
        fg = "orange";
      };
      "keyword.control" = {
        fg = "orange";
      };
      "keyword.storage" = {
        fg = "orange";
      };
      "keyword.directive" = {
        fg = "annot";
      };
      "operator" = "fg";
      "punctuation" = "fg";

      "function" = "yellow";
      "function.macro" = "orange";
      "function.builtin" = "yellow";
      "function.call" = "fg";
      "function.method" = "yellow";

      "string" = "green";
      "string.escape" = "orange";
      "string.regexp" = "green_d";
      "constant" = "purple";
      "constant.builtin" = "orange";
      "constant.numeric" = "blue";
      "constant.character.escape" = "orange";

      "variable" = "fg";
      "variable.builtin" = "orange";
      "variable.parameter" = "fg";
      "variable.other.member" = "purple";

      "type" = "fg";
      "type.builtin" = "orange";
      "constructor" = "fg";
      "namespace" = "fg";
      "label" = "annot";
      "attribute" = "annot";
      "tag" = "yellow";
      "special" = "orange";

      "markup.heading" = {
        fg = "orange";
        modifiers = [ "bold" ];
      };
      "markup.bold" = {
        modifiers = [ "bold" ];
      };
      "markup.italic" = {
        modifiers = [ "italic" ];
      };
      "markup.link.url" = {
        fg = "blue";
        modifiers = [ "underlined" ];
      };
      "markup.link.text" = "teal";
      "markup.quote" = "comment";
      "markup.raw" = "green";

      "diff.plus" = "green_d";
      "diff.minus" = "red_d";
      "diff.delta" = "blue";

      "error" = "red";
      "warning" = "warn";
      "info" = "blue";
      "hint" = "comment";
      "diagnostic.error" = {
        underline = {
          style = "curl";
          color = "red";
        };
      };
      "diagnostic.warning" = {
        underline = {
          style = "curl";
          color = "warn";
        };
      };
      "diagnostic.info" = {
        underline = {
          style = "curl";
          color = "blue";
        };
      };
      "diagnostic.hint" = {
        underline = {
          style = "dotted";
          color = "comment";
        };
      };
      "diagnostic.unnecessary" = {
        modifiers = [ "dim" ];
      };
    };
  };
}
