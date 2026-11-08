{
  config,
  pkgs,
  lib,
  ...
}:

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

  # JS/TS-family: typescript-language-server for intelligence, biome for formatting/lint
  webLangServers = [
    {
      name = "typescript-language-server";
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
  programs.helix = {
    enable = true;

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
    ];

    settings = {
      theme = "autumn_night_transparent";

      editor = {
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
        normal =
          noArrows
          // jklo_normal
          // {
            h = "no_op";
          };
        select = noArrows // jklo_select // { h = "no_op"; };
        insert = noArrows;
      };
    };

    languages = {
      language-server = {
        biome = {
          command = "biome";
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
      ];
    };

    themes = {
      autumn_night_transparent = {
        "inherits" = "autumn_night";
        "ui.background" = { };
      };
    };
  };
}
