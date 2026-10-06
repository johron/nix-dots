{ pkgs, ... }:

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
  xdg.configFile."nvim/lua".source = ./. + "/lua";

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;
    
    plugins = with pkgs.vimPlugins; [
      vim-visual-multi
      nui-nvim
      dired-nvim
      barbar-nvim
      nvim-web-devicons
    ];

    extraLuaConfig = ''
      require("neovim")
    '';
  };
}
