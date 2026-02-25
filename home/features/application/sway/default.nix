{ pkgs, lib, ... }:

let
  left = "j";
  up = "k";
  down = "l";
  right = "oslash";
  mod = "Mod1";
  super = "Super";
in
{
  imports = [
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    
  ];

  wayland.windowManager.sway = {
      enable = true;
      checkConfig = true;
      config = {
        bars = [
          {
            command = "swaybar_command waybar";
          }
        ];
        modes = {
          resize = {
            # Letters
            ${left} = "resize shrink width 10 px or 10 ppt";
            ${up} = "resize grow height 10 px or 10 ppt";
            ${down} = "resize shrink height 10 px or 10 ppt";
            ${right} = "resize grow width 10 px or 10 ppt";

            # Arrow keys
            "Left"  = "resize shrink width 10 px or 10 ppt";
            "Down"  = "resize grow height 10 px or 10 ppt";
            "Up"    = "resize shrink height 10 px or 10 ppt";
            "Right" = "resize grow width 10 px or 10 ppt";

            # Exit mode
            "Escape" = "mode default";
            "Return" = "mode default";
          };
        };
        keybindings = {
          "${mod}+Shift+r" = "reload";
          "${mod}+Shift+q" = "kill";
          "${mod}+d" = "exec rofi -show drun";
          "${mod}+Return" = "exec alacritty";
          "${super}+l" = "exec swaylock";
          "${mod}+r" = "mode \"resize\"";

          "${mod}+Shift+e" = "exec /home/johron/.config/rofi/powermenu/type-1/powermenu.sh";

          "${mod}+h" = "split h";
          "${mod}+v" = "split v";
          "${mod}+f" = "fullscreen toggle";
          "${mod}+s" = "layout stacking";
          "${mod}+t" = "layout tabbed";
          "${mod}+e" = "layout toggle split";

          "${mod}+Shift+space" = "floating toggle";
          "${mod}+space" = "focus mode_toggle";
          "${mod}+a" = "focus parent";

          # Focus movement
          "${mod}+${left}" = "focus left";
          "${mod}+${down}" = "focus down";
          "${mod}+${up}" = "focus up";
          "${mod}+${right}" = "focus right";

          # Focus movement (arrow keys)
          "${mod}+Left" = "focus left";
          "${mod}+Down" = "focus down";
          "${mod}+Up" = "focus up";
          "${mod}+Right" = "focus right";

          # Move windows
          "${mod}+Shift+${left}" = "move left";
          "${mod}+Shift+${down}" = "move down";
          "${mod}+Shift+${up}" = "move up";
          "${mod}+Shift+${right}" = "move right";

          # Move windows (arrow keys)
          "${mod}+Shift+Left" = "move left";
          "${mod}+Shift+Down" = "move down";
          "${mod}+Shift+Up" = "move up";
          "${mod}+Shift+Right" = "move right";

          # Switch to workspace
          "${mod}+1" = "workspace number 1";
          "${mod}+2" = "workspace number 2";
          "${mod}+3" = "workspace number 3";
          "${mod}+4" = "workspace number 4";
          "${mod}+5" = "workspace number 5";
          "${mod}+6" = "workspace number 6";
          "${mod}+7" = "workspace number 7";
          "${mod}+8" = "workspace number 8";
          "${mod}+9" = "workspace number 9";
          "${mod}+0" = "workspace number 10";

          ## Switch to secondary workspace
          "${super}+1" = "workspace number 11";
          "${super}+2" = "workspace number 12";
          "${super}+3" = "workspace number 13";
          "${super}+4" = "workspace number 14";
          "${super}+5" = "workspace number 15";
          "${super}+6" = "workspace number 16";
          "${super}+7" = "workspace number 17";
          "${super}+8" = "workspace number 18";
          "${super}+9" = "workspace number 19";
          "${super}+0" = "workspace number 20";

          # Move to workspace
          "${mod}+Shift+1" = "move container to workspace number 1";
          "${mod}+Shift+2" = "move container to workspace number 2";
          "${mod}+Shift+3" = "move container to workspace number 3";
          "${mod}+Shift+4" = "move container to workspace number 4";
          "${mod}+Shift+5" = "move container to workspace number 5";
          "${mod}+Shift+6" = "move container to workspace number 6";
          "${mod}+Shift+7" = "move container to workspace number 7";
          "${mod}+Shift+8" = "move container to workspace number 8";
          "${mod}+Shift+9" = "move container to workspace number 9";
          "${mod}+Shift+0" = "move container to workspace number 10";

          ## Move to secondary workspace
          "${super}+Shift+1" = "move container to workspace number 11";
          "${super}+Shift+2" = "move container to workspace number 12";
          "${super}+Shift+3" = "move container to workspace number 13";
          "${super}+Shift+4" = "move container to workspace number 14";
          "${super}+Shift+5" = "move container to workspace number 15";
          "${super}+Shift+6" = "move container to workspace number 16";
          "${super}+Shift+7" = "move container to workspace number 17";
          "${super}+Shift+8" = "move container to workspace number 18";
          "${super}+Shift+9" = "move container to workspace number 19";
          "${super}+Shift+0" = "move container to workspace number 20";

          # Multimedia
          XF86AudioMute = "exec wpctl set-mute @DEFAULT_SINK@ toggle";
          XF86AudioPlay = "exec playerctl play-pause";
          XF86AudioPause = "exec playerctl pause";
          XF86AudioNext = "exec playerctl next";
          XF86AudioPrev = "exec playerctl previous";
          XF86AudioRaiseVolume = "exec wpctl set-volume @DEFAULT_SINK@ 5%+";
          XF86AudioLowerVolume = "exec wpctl set-volume @DEFAULT_SINK@ 5%-";

          # Applications
          "${super}+q" = "exec firefox";
          "${super}+e" = "exec nemo";
          "${super}+s" = "exec spotify";
          "${super}+d" = "exec discord";

          "${super}+v" = "exec cliphist list | rofi -dmenu | cliphist decode | wl-copy";
          "${super}+Shift+s" = "exec flameshot gui";
          "${super}+Shift+c" = "exec hyprpicker --autocopy";

          # Scripts
          "${mod}+Control+a" = "exec $HOME/.config/waybar/mic-mute.sh";
          "${mod}+Control+s" = "exec $HOME/.config/waybar/output-mute.sh";
        };

        window.commands = [
          { command = "floating enable"; criteria.instance = "spotify"; }
          #{ command = "floating enable"; criteria.class = "steam"; }
        ];

        input = {
          "*" = {
           xkb_layout = "no";
           #xkb_variant = "cole";
        };
      };
    };
    extraConfig = ''
      output DP-2 pos 0 0 mode 1920x1080@143.981Hz
      output HDMI-A-1 mode 1920x1080@143.981Hz

      workspace 1 output DP-2
      workspace 2 output DP-2
      workspace 3 output DP-2

      workspace 11 output HDMI-A-1
      workspace 12 output HDMI-A-1
      workspace 13 output HDMI-A-1

      exec wl-paste --watch cliphist store
      exec flameshot

      seat seat0 xcursor_theme Notwaita-Black 20

      ## Bind Alt+Shift+e to show a Swaynag exit confirmation
      #bindsym Mod1+Shift+e exec swaynag -t warning \
      #  -m "Are you sure you want to exit Sway?" \
      #  -b "Exit" "swaymsg exit" \
      #  -b "Reboot" "reboot"

      exec swaybg -i "/storage/Pictures/Backgrounds/reef-1920x1080-2.png" -m fill

      exec_always {
        systemctl --user import-environment DISPLAY WAYLAND_DISPLAY SWAYSOCK
        lxqt-policykit-agent
        swayidle \
          timeout 600 'swaylock -f' \
          timeout 1200 'systemctl suspend' \
          before-sleep 'swaylock -f'
      }
    '';
  };
}