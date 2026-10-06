set -l base_dir "$HOME/nix-dots/data"

complete -c fme -f

set -l no_mode_set "not __fish_contains_opt -s f flake -s l license"

complete -c fme -n "$no_mode_set" -s f -l flake -d "Target dev flakes (flake)"
complete -c fme -n "$no_mode_set" -s l -l license -d "Target licenses (license)"
complete -c fme -l list -d "List available items for selected mode"

set -l get_mode_dir "
    set -l cmd (commandline -opc)
    if contains -- -l \$cmd; or contains -- --license \$cmd
        echo $base_dir/license
    else if contains -- -f \$cmd; or contains -- --flake \$cmd
        echo $base_dir/flake
    end
"

set -l get_ext "
    set -l cmd (commandline -opc)
    if contains -- -l \$cmd; or contains -- --license \$cmd
        echo txt
    else if contains -- -f \$cmd; or contains -- --flake \$cmd
        echo nix
    end
"

complete -c fme -n '__fish_is_nth_token 1' -a "(
    set -l dir ($get_mode_dir)
        if test -n \"\$dir\" -a -d \"\$dir\"
        for d in \$dir/*/
            basename \$d
        end
    end
)" -d "Category"

complete -c fme -n '__fish_is_nth_token 2' -a "(
    set -l cmd (commandline -opc)
    set -l dir ($get_mode_dir)
    set -l ext ($get_ext)
    set -l cat \$cmd[-1]
    if test -n \"\$cat\" -a -n \"\$dir\" -a -d \"\$dir/\$cat\"
        for file in \$dir/\$cat/*.\$ext
            if test -f \$file
            basename \$file .\$ext
            end
        end
    end
)" -d "Template"