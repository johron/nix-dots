set -l base_dir "$HOME/nix-dots/data"

argparse 'f/flake' 'l/license' 'list' -- $argv
or return 1

if not set -q _flag_flake; and not set -q _flag_license
    echo "Error: Must specify either --flake (-f) or --license (-l)."
    return 1
else if set -q _flag_flake; and set -q _flag_license
    echo "Error: Cannot specify both --flake and --license at the same time."
    return 1
end

set -l mode ""
set -l ext ""
set -l dest ""

if set -q _flag_flake
    set mode "flake"
    set ext "nix"
    set dest "flake.nix"
else if set -q _flag_license
    set mode "license"
    set ext "txt"
    set dest "LICENSE"
end

set -l target_base "$base_dir/$mode"

if set -q _flag_list
    if command -q tree
        tree --noreport -P "*.$ext" --prune "$target_base"
    else
        for dir in "$target_base"/*/
        if test -d "$dir"
            echo (basename "$dir")"/"
            for file in "$dir"*."$ext"
            if test -f "$file"
                echo "  └── "(basename "$file")
            end
            end
        end
        end
    end
    return 0
end

set -l tool $argv[1]
set -l name $argv[2]

if test -z "$tool"
    echo "Error: No tool/category specified."
    return 1
end

set -l target_dir "$target_base/$tool"

if not test -d "$target_dir"
    echo "Error: Directory $target_dir does not exist."
    return 1
end

set -l target_file ""
if test -n "$name"
    set target_file "$target_dir/$name.$ext"
else
    set target_file "$target_dir/default.$ext"
end

if not test -f "$target_file"
    echo "Error: File $target_file does not exist."
    return 1
end

echo "Copying $target_file -> ./$dest"
cp "$target_file" "./$dest"

if set -q _flag_flake
    echo "use flake" > .envrc
    echo ".direnv" > .gitignore

    read -l -P "Run `direnv allow`? [y/N]: " confirm
    switch $confirm
        case Y y yes Yes
            direnv allow
    end
end