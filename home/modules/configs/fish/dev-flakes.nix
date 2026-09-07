{ pkgs, ... }: {
  programs.fish = {
    functions = {
      flakeme = {
        body = ''
          set -l flake_dir "$HOME/nix-dots/dev-flakes"

          argparse 'l/list' -- $argv
          or return 1

          if set -q _flag_list
            if command -q tree
              tree --noreport -P '*.nix' --prune "$flake_dir"
            else
              for dir in "$flake_dir"/*/
                if test -d "$dir"
                  echo (basename "$dir")"/"
                  for file in "$dir"*.nix
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
            echo "Error: No tool specified."
            return 1
          end

          set -l target_dir "$flake_dir/$tool"

          if not test -d "$target_dir"
            echo "Error: Directory $target_dir does not exist."
            return 1
          end

          set -l target_file ""
          if test -n "$name"
            set target_file "$target_dir/$name.nix"
          else
            set target_file "$target_dir/default.nix"
          end

          if not test -f "$target_file"
            echo "Error: File $target_file does not exist."
            return 1
          end

          echo "Selected: $target_file"
          cp $target_file ./flake.nix
        '';
      };
    };

    completions = {
      flakeme = ''
        set -l flake_dir "$HOME/nix-dots/dev-flakes"

        complete -c flakeme -f

        complete -c flakeme -s l -l list -d "List available dev flakes"

        complete -c flakeme -n '__fish_is_nth_token 1' -a "(
          if test -d $flake_dir
            for dir in $flake_dir/*/
              basename \$dir
            end
          end
        )" -d "Tool directory"

        complete -c flakeme -n '__fish_is_nth_token 2' -a "(
          set -l cmd (commandline -opc)
          set -l tool \$cmd[2]
          if test -n \"\$tool\" -a -d $flake_dir/\$tool
            for file in $flake_dir/\$tool/*.nix
              if test -f \$file
                basename \$file .nix
              end
            end
          end
        )" -d "Flake template name"
      '';
    };
  };
}