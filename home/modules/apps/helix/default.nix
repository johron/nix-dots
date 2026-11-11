{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:

let
  noArrows = {
    up = "no_op";
    down = "no_op";
    left = "no_op";
    right = "no_op";
  };

  # JS/TS-family: typescript-language-server for intelligence, biome for formatting/lint
  webLangServers = [
    {
      name = "${lib.getExe pkgs.typescript-language-server}";
      except-features = [ "format" ];
    }
    "biome"
  ];

  mkWebLang = name: {
    inherit name;
    language-servers = webLangServers;
    auto-format = true;
  };
in
{
  imports = [ inputs.helix-plugins.homeManagerModules.default ];

  xdg.configFile."helix/scm" = {
    source = ./scm;
    recursive = true;
  };

  xdg.configFile."helix/init.scm".source = ./init.scm;

  home.packages = with pkgs; [
    typescript-language-server
    biome
  ];

  programs.helix = {
    enable = true;

    package = pkgs.steelix;

    extraPackages = with pkgs; [
      lua-language-server
      stylua

      typescript
      typescript-language-server
      biome

      vscode-langservers-extracted

      basedpyright
      ruff

      gopls
      delve

      rust-analyzer

      nil
      nixfmt

      steel-language-server

      prisma-language-server
    ];

    plugins = {
      inherit (pkgs.helixPlugins)
        oil-hx
        steel-pty # include for libs..
        case-hx
        # cliff-hx
        scooter-hx
        # scopeline-hx
        # vista-hx
        yank-flash-hx
        ;

      "steel-pty-fish" = pkgs.fetchFromGitHub {
        owner = "johron";
        repo = "steel-pty-fish";
        rev = "6f2d4c970359dc36c04abf992ab5e95bb1866788";
        hash = "sha256-uXZxwgWKZD7QGIHcVIm337Cv+4TirHfQ4pF9gqJ79OI=";
      };
    };

    settings = {
      theme = "darcula_intellij";

      editor = {
        default-yank-register = "+";
        line-number = "relative";
        bufferline = "always";

        lsp.display-inlay-hints = true;
        cursor-shape = {
          normal = "block";
          insert = "bar";
          select = "underline";
        };
        auto-save = {
          focus-lost = true;
          after-delay = {
            enable = true;
          };
        };
      };

      keys = {
        normal = {
          space.B = ":blame-line";
        };
        insert = {
          "C-h" = "move_char_left";
          "C-j" = "move_line_down";
          "C-k" = "move_line_up";
          "C-l" = "move_char_right";
        };
      };
    };

    languages = {
      language-server = {
        biome = {
          command = "${lib.getExe pkgs.biome}";
          args = [ "lsp-proxy" ];
        };

        ruff = {
          command = "ruff";
          args = [ "server" ];
        };

        basedpyright = {
          command = "basedpyright-langserver";
          args = [ "--stdio" ];
        };

        nil = {
          command = "nil";
          config.nil.formatting.command = [ "nixfmt" ];
        };

        rust-analyzer.config.check.command = "clippy";

        steel-language-server = {
          command = "steel-language-server";
          environment = {
            STEEL_HOME = "~/.local/share/steel";
          };
        };

        prisma-language-server = {
          command = "prisma-language-server";
          args = [ "--stdio" ];
          config = {
            prisma = {
              enableDiagnostics = true;
            };
          };
        };
      };

      language = [
        (mkWebLang "javascript")
        (mkWebLang "typescript")
        (mkWebLang "jsx")
        (mkWebLang "tsx")

        {
          name = "json";
          language-servers = [
            {
              name = "vscode-json-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
          auto-format = true;
        }
        {
          name = "css";
          language-servers = [
            {
              name = "vscode-css-language-server";
              except-features = [ "format" ];
            }
            "biome"
          ];
          auto-format = true;
        }
        {
          name = "html";
          language-servers = [ "vscode-html-language-server" ];
          auto-format = false;
        }
        {
          name = "lua";
          language-servers = [ "lua-language-server" ];
          auto-format = true;
          formatter = {
            command = "stylua";
            args = [ "-" ];
          };
        }
        {
          name = "python";
          language-servers = [
            "basedpyright"
            "ruff"
          ];
          auto-format = true;
          formatter = {
            command = "ruff";
            args = [
              "format"
              "-"
            ];
          };
        }
        {
          name = "go";
          language-servers = [ "gopls" ];
          auto-format = true;
        }
        {
          name = "rust";
          language-servers = [ "rust-analyzer" ];
          auto-format = true;
        }
        {
          name = "nix";
          language-servers = [ "nil" ];
          auto-format = true;
          formatter.command = lib.getExe pkgs.nixfmt;
        }

        {
          name = "scheme";
          auto-format = true;
          language-servers = [ "steel-language-server" ];
        }
        {
          name = "prisma";
          auto-format = true;
          language-servers = [ "prisma-language-server" ];
        }
      ];
    };

    themes = {
      darcula_intellij = {
        palette = {
          panel = "#1a1a1a";
          panel_alt = "#141414";
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
          bg = "line";
        };
        "ui.cursorline.secondary" = {
          bg = "line";
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
  };
}
