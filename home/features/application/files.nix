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
          alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
          home() {
            cd "$HOME/home-manager"
            "$EDITOR" "$HOME/home-manager/home.nix"
          }
          flake() {
            cd "$HOME/home-manager"
            "$EDITOR" "$HOME/home-manager/flake.nix"
          }
          config() {
            "sudo" "$EDITOR" "/etc/nixos/configuration.nix"
          }
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
      flameshot = {
        target = ".config/flameshot/flameshot.ini";
        text = ''
          [General]
          contrastOpacity=188
          showAbortNotification=false
          showDesktopNotification=false
          showStartupLaunchMessage=false
          savePath=/home/johron/Pictures/Screenshots
          savePathFixed=true
        '';
      };
      mako = {
        target = ".config/mako/config";
        text = ''
          default-timeout=5000
        '';
      };
      clock = {
        target = ".config/waybar/clock.sh";
        text = ''
        # Generate the formatted date string
        formatted_date=$(LC_TIME=nb_NO.UTF-8 date +"%H:%M %A, %b %d" | tr '[:upper:]' '[:lower:]' | sed 's/\.//g')

        # Output as JSON for Waybar
        printf '{"text": "%s"}\n' "$formatted_date"
        '';
        executable = true;
      };
      memory = {
        target = ".config/waybar/memory.sh";
        text = ''
          free -m | awk '
          /^Mem:/ {
              current_gb = $3 / 1024;
              total_gb = $2 / 1024;
              printf "{\"text\": \"%.1fG/%.1fG\"}\n", current_gb, total_gb
          }'
        '';
        executable = true;
      };
      volume = {
        target = ".config/waybar/volume.sh";
        text = ''
          VOLUME_INFO=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
          VOL_NUM=$(echo "$VOLUME_INFO" | awk '{print $2}')
          VOL_PERC=$(awk -v n="$VOL_NUM" 'BEGIN {print int(n * 100)}')

          if [[ "$VOLUME_INFO" == *"[MUTED]"* ]]; then
              RESULT="Muted ($VOL_PERC%)"
          else
              RESULT="$VOL_PERC%"
          fi

          echo "{\"text\": \"$RESULT\"}"
        '';
        executable = true;
      };
    };
  };
}