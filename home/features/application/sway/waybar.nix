{ pkgs, lib, ... }:
{
  imports = [
    ./scripts.nix
  ];

  programs.waybar = {
    enable = true;
    settings = {
      main = {
        position = "bottom";
        layer = "top";
        exclusive = "false";
        height = 30;
        spacing = 5;
        modules-left = [ "custom/block_start" "sway/workspaces" "mpris" "custom/block_stop" "sway/mode" ];
        modules-center = [ "custom/block_start" "custom/clock" "custom/block_stop" ];
        modules-right = [ "custom/block_start" "custom/memory" "custom/slash" "custom/volume" "custom/block_stop" "tray" ];

        "mpris" = {
          player = "spotify";
          format = "<span color=\"#272727\">/</span> <span color=\"#ACA69E\">mus:</span> {artist} - {title}";
          format-paused = "<span color=\"#272727\">/</span> <span color=\"#ACA69E\">mus:</span> {artist}";
          max-length = 200;
        };

        "sway/workspaces" = {
          format = "{icon}{name}";
          on-click = "activate";
          icon-size = 10;
          sort-by-number = "true";
          justify = "right";
          "format-icons" = {
            focused = "*";
            urgent = "!";
            default = "";
          };
        };

        "custom/space" = {
          format = " ";
        };

        "custom/slash" = {
          format = "/ ";
        };

        "custom/block_start" = {
          format = " [";
        };

        "custom/block_stop" = {
          format = "] ";
        };

        "custom/clock" = {
          format = "{}";
          exec = "~/.config/waybar/clock.sh";
          return-type = "json";
          restart-interval = 1;
        };

        "battery" = {
          bat = "BAT1";
          interval = 60;
          format = "{icon} {capacity}%";
          format-icons = ["\uf244" "\uf243" "\uf242" "\uf241" "\uf240"];
        };

        "custom/volume" = {
          format = "<span color=\"#ACA69E\">vol:</span> {} ";
          exec = "~/.config/waybar/volume.sh";
          return-type = "json";
          restart-interval = 0;
        };

        "custom/memory" = {
          format = "<span color=\"#ACA69E\">mem:</span> {} ";
          exec = "~/.config/waybar/memory.sh";
          return-type = "json";
          restart-interval = 1;
        };

        "custom/lang" = {
          format = "<span color=\"#ACA69E\">key:</span> no";
        };

        "tray" = {
          icon-size = 16;
          spacing = 16;
        };
      };
    };
    style = ''
      @define-color foreground #ACA69E;
      @define-color foreground-inactive #ffffff;
      @define-color background #101010;

      * {
        font-family: JetBrainsMono Nerd Font;
        font-size: 12px;
      }

      #waybar {
        color: #ffffff;
        background-color: @background;
      }

      #workspaces {
        background: transparent;
      }

      #custom-slash,
      #custom-block_start,
      #custom-block_stop {
        color: #272727;
      }

      #workspaces button {
        min-width: 20px;
        padding: 0 0.6em;
        margin: 0 0.2em;
        color: @foreground-inactive;

        background: transparent;
        border: none;
        border-bottom: 2px solid transparent;
        border-radius: 0;
        padding: 0px;
        margin: 0 5px;
      }

      #workspaces button.active,
      #workspaces button.focused {
        color: #ACA69E;
        /*border-bottom: 2px solid @foreground;*/
      }

      #workspaces button.empty {
        color: #ACA69E;
      }

      #workspaces button.urgent {
        color: #A64443;
      }

      #workspaces button:hover {
        color: @foreground;
      }

      #mode {
        color: #A64443;
      }

      #memory,
      #wireplumber,
      #battery,
      #idle_inhibitor,
      #language,
      #network,
      #bluetooth,
      #tray {
        padding-right: 1em
      }
    '';
  };
}