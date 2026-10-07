{ pkgs, inputs, ... }:

let
  dired-nvim = pkgs.vimUtils.buildVimPlugin {
    name = "dired.nvim";
    src = pkgs.fetchFromGitHub {
      owner = "X3eRo0";
      repo = "dired.nvim";
      rev = "master"; 
      sha256 = "sha256-cPbfSoVxKlsUaiHMJ74FROL+9KnZRE4Ed+n823gc/04=";
    };
    dependencies = [ pkgs.vimPlugins.nui-nvim ];
  };
in
{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;

    nixpkgs.config.allowUnfree = true; 

    opts = {
      number = true;
      relativenumber = true;

      shiftwidth = 4;
    };

    keymaps = [
      {
        mode = [ "i" "v" "c" ];
        key = "<F12>";
        action = "<C-c>";
      }
      {
        mode = [ "i" "v" "c" ];
        key = "<Esc>";
        action = "<Nop>";
      }
      {
        mode = [ "n" "v" ];
        key = "ø";
        action = ":";
      }
      {
        mode = [ "n" "v" ];
        key = ":";
        action = "<Nop>";
      }
    ];

    colorscheme = "retrobox";

    plugins = {
      visual-multi.enable = true;
      barbar = {
        enable = true;
        settings = {
          pinned = {
            button = false;
          };
          icons = {
            button = false;
            modified.button = false;
            buffer_index = false;
            filetype = {
              custom_colors = false;
              enabled = true;
            };
          };
        };
      };
      web-devicons.enable = true;
    };

    extraPlugins = with pkgs.vimPlugins; [
      nui-nvim
      dired-nvim
    ];

    extraConfigLua = ''
      require("dired").setup({
        path_separator = "/",
        show_hidden = true,
        show_icons = true,
      })
    '';
  };
}
