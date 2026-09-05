{ pkgs, ... }: {
  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      set -g fish_greeting ""
      direnv hook fish | source
    '';

    functions = {
      current_git_branch = ''
        git symbolic-ref --quiet --short HEAD 2>/dev/null | read -l branch
        and printf '(%s)' $branch
      '';

      shlvl_prompt = ''
        if test "$SHLVL" -gt 1
            printf '(%d)' "$SHLVL"
        end
      '';

      jclone = ''
        git clone git@github.com:johron/$argv[1]
      '';

      nix-update = ''
        set -l orig_cwd (pwd)

        cd ~/nix-dots || return

        nix flake update
        or begin
            cd $orig_cwd
            return 1
        end

        nh os switch
        or begin
            cd $orig_cwd
            return 1
        end

        flatpak update -y

        cd $orig_cwd
      '';

      fish_prompt = ''
        set -g fish_prompt_pwd_dir_length 0
        
        set -l primary_color "brblue"
        set -l pwd_color "blue"

        switch (prompt_hostname)
            case 'nixstation'
                set primary_color "brblue"
                set pwd_color "blue"
            case 'ideapad'
                set primary_color "cyan"
                set pwd_color "brcyan"
            case 'moholt'
                set primary_color "yellow"
                set pwd_color "bryellow"
            case '*'
                set primary_color "red"
                set pwd_color "brred"
        end

        set_color normal
        shlvl_prompt

        set_color normal
        printf "("

        set_color --bold $primary_color
        printf "%s" $USER

        set_color normal
        printf "@"

        set_color --bold $primary_color
        printf "%s" (prompt_hostname)

        set_color normal
        printf ":"

        set_color --bold $pwd_color
        printf "%s" (prompt_pwd)

        set_color normal
        printf ")"

        set_color --bold brgreen
        current_git_branch

        set_color normal
        printf '$ '
      '';
    };
  };
}
