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
  };
}