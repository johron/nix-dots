{ pkgs, ... }: {
  programs.fish = {
    functions = {
      devflake = {
        body = ''
          set -l flake_dir "$HOME/nix-dots/dev-flakes"
          echo $flake_dir
          echo $tool, $name
        '';
        argumentNames = [ "tool" "name" ];
      };
    };
  };
}
