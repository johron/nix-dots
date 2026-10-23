set -g project_roots \
    pu "$HOME/Projects/untracked" \
    pj "$HOME/Projects/johron" \
    pd "$HOME/Projects/dotkom" \
    pz "$HOME/Projects/zelkel-lang"

set -g project_max_depth 2

function project_cd --description 'cd to a project root'
    set -l root $argv[1]
    set -l target $root

    if test (count $argv) -gt 1
        set target "$root/"(string join / $argv[2..-1])
    end

    cd "$target"
end

function __project_find_dirs
    set -l base $argv[1]
    set -l depth $argv[2]
    set -l extra $argv[3..-1]

    command find "$base" -mindepth 1 -maxdepth $depth \
        \( -name '.*' -o -name node_modules -o -name target -o -name venv \
           -o -name __pycache__ -o -name dist -o -name build \) -prune -o \
        -type d $extra -printf '%P\n' 2>/dev/null
end

function __project_complete_directories --argument-names base
    __project_find_dirs "$base" 1
end

function __project_complete_subdirectories --argument-names base
    __project_find_dirs "$base" $project_max_depth
end

function p --description 'cd to a project directory anywhere under ~/Projects'
    set -l root "$HOME/Projects"

    if test (count $argv) -eq 0
        cd "$root"
        return
    end

    set -l target (string join / $argv)

    if test -d "$root/$target"
        cd "$root/$target"
        return
    end

    set -l matches (__project_find_dirs "$root" $project_max_depth -name "$target")

    switch (count $matches)
        case 1
            cd "$root/$matches[1]"
        case 0
            cd "$root/$target"
        case '*'
            printf '%s\n' $matches
            return 1
    end
end

for i in (seq 1 2 (count $project_roots))
    set -l name $project_roots[$i]
    set -l root $project_roots[(math $i + 1)]

    function $name --inherit-variable root --description "cd to $root"
        project_cd "$root" $argv
    end

    complete -c $name -f -a "(__project_complete_directories \"$root\")"
end

complete -c p -f -a "(__project_complete_subdirectories \"$HOME/Projects\")"