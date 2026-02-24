{ pkgs, lib, ... }:
{
  home = {
    file = {
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