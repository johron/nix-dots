{ pkgs, lib, ... }:
{
  programs.waybar = {
    enable = true;
    settings = {
      main = {
        layer = "top";
        position = "bottom";
        height = 16;
        spacing = 0;

        modules-left = [
          "sway/workspaces"
          "mpris"
        ];
        modules-center = [
          "clock"
        ];
        modules-right = [
          "tray"
          "custom/cap-left"
          "pulseaudio"
          "network"
          "battery"
          "custom/cap-right"
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
          format-wifi = "󰖩";
          format-ethernet = "󰈀";
          format-disconnected = "󰖪";
          tooltip-format = "{essid}\n{ipaddr}";
        };

        pulseaudio = {
          format = "{icon}";
          tooltip-format = "{volume}%";
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

        "custom/cap-left" = {
          format = " ";
          tooltip = false;
        };

        "custom/cap-right" = {
          format = " ";
          tooltip = false;
        };
      };
    };
    style = ''
      * {
        border: none;
        font-family: "JetBrainsMono Nerd Font", "Material Symbols Rounded";
        font-size: 12px;
      }

      window#waybar {
        background: rgb(26,28,23);
        border-radius: 0px;
      }

      #clock,
      #tray,
      #mpris,
      #workspaces,
      #workspace button {
        background: rgb(35,39,29);

        color: #e6e1e5;
        font-weight: 600;

        min-width: 12px;
        min-height: 12px;
        padding: 0 6px;
        margin: 2px 2px;
        border-radius: 10px;

        border: 1px solid rgba(255,255,255,0.08);
        transition: all 0.2s ease;
      }

      #workspaces {
        padding: 0;
      }

      #workspaces button label {
        padding: 0;
        margin: 0;
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

      #pulseaudio,
      #network,
      #battery {
        background: rgb(35,39,29);
        color: #e6e1e5;
        font-weight: 600;

        padding: 0 6px;
        margin: 2px 0;
        border-radius: 0;

        border-top: 1px solid rgba(255,255,255,0.08);
        border-bottom: 1px solid rgba(255,255,255,0.08);
      }

      #pulseaudio {
        font-size: 18px;
      }

      #custom-cap-left {
        background: rgb(35,39,29);
        margin: 2px 0 2px 2px;

        border-radius: 12px 0 0 12px;
        padding: 0 3px;

        border: 1px solid rgba(255,255,255,0.08);
        border-right: none;
      }

      #custom-cap-right {
        background: rgb(35,39,29);
        margin: 2px 2px 2px 0;

        border-radius: 0 12px 12px 0;
        padding: 0 2px;

        border: 1px solid rgba(255,255,255,0.08);
        border-left: none;
      }
    '';
  };
}