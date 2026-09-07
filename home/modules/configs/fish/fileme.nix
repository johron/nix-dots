{ pkgs, ... }: {
  programs.fish = {
    functions = {
      fme = {
        body = ''
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
        '';
      };
    };

    completions = {
      fme = ''
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
      '';
    };
  };
}