{ pkgs, lib, ... }:

let
  folder = ".config/eww/widgets/network";
  scripts = "${folder}/scripts";
in 
{
  home = {
    file = {
      "${folder}/network.yuck".source = ./network.yuck;
      "${folder}/network.scss".source = ./network.scss;

      "${scripts}/available_wifi.py" = {
        source = ./scripts/available_wifi.py;
        executable = true;
      };
      "${scripts}/connected.py" = {
        source = ./scripts/connected.py;
        executable = true;
      };
      "${scripts}/devices.py" = {
        source = ./scripts/devices.py;
        executable = true;
      };

      "${scripts}/connect_wifi.sh" = {
        source = ./scripts/connect_wifi.sh;
        executable = true;
      };
      "${scripts}/disconnect_wifi.sh" = {
        text = ''
          #!/usr/bin/env bash
          nmcli connection down id "$1"
        '';
        executable = true;
      };
      "${scripts}/device_up.sh" = {
        text = ''
          #!/usr/bin/env bash
          nmcli device connect $1
        '';
        executable = true;
      };
      "${scripts}/device_down.sh" = {
        text = ''
          #!/usr/bin/env bash
          nmcli device disconnect $1
        '';
        executable = true;
      };
    };
  };
}