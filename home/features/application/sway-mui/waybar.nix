{ pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      main = {
        layer = "top";
        position = "bottom";
        height = 32;
        spacing = 2;

        modules-left = [
          "sway/workspaces"
          "mpris"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "pulseaudio"
          "network"
          "battery"
          "tray"
        ];

        clock = {
          format = "󰥔  {:%H:%M}";
          tooltip = false;
        };

        battery = {
          format = "{icon} {capacity}%";
          format-icons = [
            "󰁺"
            "󰁻"
            "󰁼"
            "󰁽"
            "󰁾"
            "󰁿"
            "󰂀"
            "󰂁"
            "󰂂"
            "󰁹"
          ];
        };

        network = {
          format-wifi = "";
          format-ethernet = "";
          tooltip-format = "{essid}";
        };

        pulseaudio = {
          format = "{icon} {volume}%";
          format-icons = {
            default = [
              "󰕿"
              "󰖀"
              "󰕾"
            ];
          };
        };

        mpris = {
          format = "{artist} - {title}";
          format-paused = "{artist} - {title}";
          max-length = 25;
        };
      };
    };
    style = ''
      * {
        border: none;
        font-family: "Roboto", "Material Symbols Rounded";
        font-size: 14px;
        min-height: 0;
      }

      window#waybar {
        background: rgb(26,28,23);
        margin-top: 8px;
        border-radius: 0px;
      }

      /* Shared module styling */
      #clock,
      #battery,
      #network,
      #pulseaudio,
      #tray,
      #mpris,
      #workspaces {
        background: rgb(35,39,29);

        color: #e6e1e5;
        font-weight: 600;

        min-width: 12px;
        min-height: 12px;
        padding: 0 6px;
        margin: 2px 2px;
        border-radius: 10px;

        border: 1px solid rgba(255,255,255,0.08);
      }

      #workspaces {
        padding: 0;
      }

      #workspaces button label {
        padding: 0;
        margin: 0;
      }

      #workspaces button {
        color: #c4c7c5;
        padding: 0 10px;
        border-radius: 10px;
        transition: all 0.2s ease;
      }

      #workspaces button.active,
      #workspaces button.focused {
        background: rgba(103, 80, 164, 0.4);
        color: white;
      }

      #workspaces button:hover {
        background: rgba(255,255,255,0.08);
      }

      #mpris.playing {
        background: rgba(139, 188, 255, 0.2);
      }

      #mpris.spotify.playing {
        background: rgba(29,185,84,0.2);
      }

      #mpris.firefox.playing {
        background: rgba(255,102,42,0.2);
      }

      #battery {
      }

      #network {
      }

      #pulseaudio {
      }

      #clock {
      }
    '';
  };
}