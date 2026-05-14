{ pkgs, lib, ... }:
{
  imports = [
    ./style.nix
  ];
  
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
          "sway/mode"
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

        "sway/mode" = {
          format = "transform";
        };

        "custom/clock" = {
          format = "{}";
          exec = ''
            formatted_date=$(LC_TIME=nb_NO.UTF-8 date +"%H:%M %A, %d %b" | tr '[:upper:]' '[:lower:]' | sed 's/\.//g')
            printf '{"text": "%s"}\n' "$formatted_date"
          '';
          return-type = "json";
          restart-interval = 1;
        };

        tray = {
          spacing = 8;
        };

        battery = {
          format = "{icon}";
          tooltip-format = "{capacity}%";
          format-icons = {
            default = [
              "battery_android_0"
              "battery_android_1"
              "battery_android_2"
              "battery_android_3"
              "battery_android_4"
              "battery_android_5"
              "battery_android_6"
              "battery_android_full"
            ];
            charging = [
              "battery_charging_full_2"
              "battery_charging_20_2"
              "battery_charging_30_2"
              "battery_charging_50_2"
              "battery_charging_60_2"
              "battery_charging_80_2"
            ];
          };
        };

        network = {
          format-wifi = "{icon}";
          format-icons = [
            "signal_wifi_0_bar"
            "network_wifi_1_bar"
            "network_wifi_2_bar"
            "network_wifi_3_bar"
            "network_wifi"
            "signal_wifi_4_bar"
          ];
          format-ethernet = "lan";
          format-disconnected = "signal_wifi_off";
          format-disabled = "flight";
          format-linked = "lan";
          tooltip-format = "{essid}\n{ipaddr}";
          on-click = "eww open network --toggle --screen $(swaymsg -t get_outputs | jq 'map(.focused) | index(true)')";
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
          format = "{icon}";
          format-on = "bluetooth";
          format-off = "bluetooth_disabled";
          format-disabled = "bluetooth_disabled";
          format-connected = "bluetooth_connected";
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
  };
}