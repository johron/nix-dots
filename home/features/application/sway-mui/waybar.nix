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
          "custom/clock"
        ];
        modules-right = [
          "tray"
          "custom/cap-left"
          "pulseaudio"
          "bluetooth"
          "network"
          "battery"
          "custom/cap-right"
        ];

        "custom/clock" = {
          format = "{}";
          exec = "~/.config/waybar/clock.sh";
          return-type = "json";
          restart-interval = 1;
        };

        tray = {
          spacing = 8;
        };

        battery = {
          format = "{icon}";
          tooltip-format = "{capacity}%";
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
          format-wifi = "{icon}";
          format-icons = [
            "󰤯"
            "󰤟"
            "󰤢"
            "󰤥"
            "󰤨"
          ];
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

        bluetooth = {
          format-on = "󰂯";
          format-off = "󰂲";
          format-disabled = "";
          format-connected = "󰂱 {num_connections}";
          tooltip-format-connected = "{device_enumerate}";
          tooltip-format-enumerate-connected = "{device_alias}\t{device_address}";
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
        font-weight: 700;
      }

      window#waybar {
        /*background: rgb(26,28,23);*/
        background: rgb(10,1,1);
        border-radius: 0px;
      }

      #custom-clock,
      #tray,
      #mpris,
      #workspaces,
      #workspace button {
        background: rgb(16,2,2);

        color: #e6e1e5;

        min-width: 12px;
        min-height: 12px;
        padding: 0 6px;
        margin: 2px 2px;
        border-radius: 10px;

        /*border: 1px solid rgba(255,255,255,0.08);*/
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
        background: rgba(57, 150, 181, 0.1);
        color: white;
      }

      #workspaces button:hover {
        background: rgba(255,255,255,0.08);
      }

      #mpris.playing {
        background: rgba(57, 150, 181, 0.1);
      }

      #mpris.spotify.playing {
        background: rgba(29,185,84,0.1);
      }

      #mpris.firefox.playing {
        background: rgba(255,102,42,0.1);
      }

      #pulseaudio,
      #network,
      #bluetooth,
      #battery,
      #custom-taskmgr {
        font-family: "Material Symbols Rounded";
        background: rgb(16,2,2);
        color: #e6e1e5;
        font-weight: 600;

        padding: 0 6px;
        margin: 2px 0;
        border-radius: 0;

        /*border-top: 1px solid rgba(255,255,255,0.08);
        border-bottom: 1px solid rgba(255,255,255,0.08);*/
      }

      #pulseaudio {
        font-size: 18px;
      }

      #bluetooth,
      #network {
        font-size: 14px;
      }

      #custom-cap-left {
        background: rgb(16,2,2);
        margin: 2px 0 2px 2px;

        border-radius: 12px 0 0 12px;
        padding: 0 1px;

        /*border: 1px solid rgba(255,255,255,0.08);
        border-right: none;*/
      }

      #custom-cap-right {
        background: rgb(16,2,2);
        margin: 2px 2px 2px 0;

        border-radius: 0 12px 12px 0;
        padding: 0 3px;

        /*border: 1px solid rgba(255,255,255,0.08);
        border-left: none;*/
      }
    '';
  };
}