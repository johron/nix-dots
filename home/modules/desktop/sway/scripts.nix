{ pkgs, lib, ... }:
{
  home = {
    file = {
      mic-mute = {
        target = ".config/waybar/mic-mute.sh";
        text = ''
          #!/usr/bin/env bash

          # Toggle mute
          amixer set 'Capture' toggle

          # Check new state
          if amixer get Capture | grep -q '\[off\]'; then
            notify-send "Microphone Muted" "Your mic has been muted." -i microphone-sensitivity-muted-symbolic
          else
            notify-send "Microphone Unmuted" "Your mic is live." -i microphone-sensitivity-high-symbolic  
          fi
        '';
        executable = true;
      };
      output-mute = {
        target = ".config/waybar/output-mute.sh";
        text = ''
          #!/usr/bin/env bash

          # Toggle mute
          amixer set 'Master' toggle

          # Check new state
          if amixer get Master | grep -q '\[off\]'; then
            notify-send "Master Muted" "You may no longer hear." -i audio-volume-muted-symbolic
          else
            notify-send "Master Unmuted" "You may hear now." -i audio-volume-high-symbolic  
          fi
        '';
        executable = true;
      };
      screenshot = {
        target = "Scripts/ss.sh";
        text = ''
          FILE=~/Pictures/Screenshots/$(date +%F_%T).png
          grim -g "$(slurp)" "$FILE"
          wl-copy < "$FILE"
          swappy -f "$FILE"
        '';
        executable = true;
      };
    };
  };
}