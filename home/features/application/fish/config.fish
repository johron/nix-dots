set -U fish_greeting ""
direnv hook fish | source

function current_git_branch
    git symbolic-ref --quiet --short HEAD 2>/dev/null | read -l branch
    and printf '(%s)' $branch
end

function shlvl_prompt
    if test "$SHLVL" -gt 1
        printf '(%d)' "$SHLVL"
    end
end

function fish_prompt
    set -g fish_prompt_pwd_dir_length 0
    set_color normal
    shlvl_prompt

    set_color normal
    printf "("

    set_color --bold brblue
    printf "%s" $USER

    set_color normal
    printf "@"

    set_color --bold brblue
    printf "%s" (prompt_hostname)

    set_color normal
    printf ":"

    set_color --bold blue
    printf "%s" (prompt_pwd)

    set_color normal
    printf ")"

    set_color --bold brgreen
    current_git_branch

    set_color normal
    printf '$ '
end

function nix-update
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
end

function jclone
    git clone https://github.com/johron/$argv[1]
end