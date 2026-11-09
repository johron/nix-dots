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
