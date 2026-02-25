{ pkgs, lib, ... }:
{
  home = {
    file = {
      bashrc = {
        target = ".bashrc";
        text = ''
          current_git_branch() {
            git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
          }
          shlvl_prompt() {
            (( SHLVL > 1 )) && printf '(%d)' "$SHLVL"
          }
          PS1='$(shlvl_prompt)(\[\033[01;94m\]\u\[\033[00;00m\]@\[\033[01;94m\]\h\[\033[00;00m\]:\[\033[01;34m\]\w\[\033[00m\])\[\033[01;32m\]$(current_git_branch)\[\033[00m\]$ '
          nix-update() {
            set -e

            ORIG_CWD="$(pwd)"

            sudo nix-channel --update
            cd "$HOME/home-manager"
            make
            sudo nixos-rebuild switch
            flatpak update -y
            sudo flatpak update -y
            cd "$ORIG_CWD"
          }
          jclone() {
            git clone https://github.com/johron/$1
          }
        '';
      };
    };
  };
}