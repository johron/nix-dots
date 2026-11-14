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

  mkWebLang = name: ext: {
    inherit name;
    language-servers = [
      "typescript-language-server"
      "biome"
    ];
    auto-format = true;
    formatter = {
      command = lib.getExe pkgs.biome;
      args = [
        "format"
        "--stdin-file-path=stdin.${ext}"
      ];
    };
  };
in
{
  imports = [
    inputs.helix-plugins.homeManagerModules.default
    ./darcula-intellij.nix
  ];

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

      tailwindcss-language-server
    ];

    plugins = {
      inherit (pkgs.helixPlugins)
        oil-hx
        steel-pty # include for libs..
        case-hx
        scooter-hx
        grove-hx
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
        cursorline = true;

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

        typescript-language-server = {
          command = lib.getExe pkgs.typescript-language-server;
          args = [ "--stdio" ];
          config = {
            hostInfo = "helix";
            disableAutomaticTypingAcquisition = true;
            tsserver = {
              path = "${pkgs.typescript}/lib/node_modules/typescript/lib/tsserver.js";
              logDirectory = "/tmp/tsserver";
            };
          };
        };

        biome = {
          command = lib.getExe pkgs.biome;
          args = [ "lsp-proxy" ];
          required-root-patterns = [ ];
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
        (mkWebLang "javascript" "js")
        (mkWebLang "typescript" "ts")
        (mkWebLang "jsx" "jsx")
        (mkWebLang "tsx" "tsx")

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
            # "basedpyright"
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
  };
}
