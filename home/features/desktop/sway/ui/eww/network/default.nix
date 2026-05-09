{ pkgs, lib, ... }:

let
  folder = ".config/eww/widgets/network";
  scripts = "${folder}/scripts";
in 
{
  home = {
    file = {
      "${folder}/network.yuck".source = ./network.yuck;
      network_scss = {
        target = "${folder}/network.scss";
        text = ''
          .network-menu {
            background: #1e1e2e;
            border-radius: 14px;
            padding: 16px;
            min-width: 320px;
          }

          .title {
            font-size: 22px;
            margin-bottom: 12px;
          }

          button {
            background: #313244;
            border-radius: 10px;
            padding: 10px;
            margin: 4px 0;
          }

          button:hover {
            background: #45475a;
          }
        '';
      };
      network_connections_sh = {
        target = "${scripts}/connections.sh";
        executable = true;
        text = ''
          #!/usr/bin/env bash

          echo '(box :orientation "v" :spacing 12'

          #
          # ACTIVE CONNECTIONS
          #

          echo '(label :text "Connected")'

          nmcli -t -f NAME,TYPE,DEVICE connection show --active | \
          while IFS=: read -r name type device
          do
              icon="󰈀"

              case "$type" in
                  802-11-wireless)
                      icon="󰤨"
                      ;;
                  802-3-ethernet)
                      icon="󰈁"
                      ;;
                  vpn)
                      icon="󰖂"
                      ;;
              esac

              safe_name=$(printf '%s\n' "$name" | sed 's/"/\\"/g')

              echo "(button
                  :onclick \"~/.config/eww/widgets/network/scripts/disconnect.sh '$safe_name'\"
                  (box :orientation \"h\" :spacing 12
                      (label :text \"$icon\")
                      (label :text \"$safe_name\")
                      (label :text \"Connected\")
                  )
              )"
          done

          #
          # WIFI NETWORKS
          #

          echo '(label :text "Wi-Fi")'

          nmcli -t -f SSID,SIGNAL device wifi list | \
          awk -F: '
          {
              ssid=$1
              signal=$2

              if (ssid == "")
                  next

              if (!(ssid in best) || signal > best[ssid]) {
                  best[ssid]=signal
              }
          }
          END {
              for (ssid in best)
                  print ssid ":" best[ssid]
          }
          ' | sort -t: -k2 -nr | \
          while IFS=: read -r ssid signal
          do
              safe_ssid=$(printf '%s\n' "$ssid" | sed 's/"/\\"/g')

              if [ "$signal" -ge 80 ]; then
                  icon="󰤨"
              elif [ "$signal" -ge 60 ]; then
                  icon="󰤥"
              elif [ "$signal" -ge 40 ]; then
                  icon="󰤢"
              else
                  icon="󰤟"
              fi

              echo "(button
                  :onclick \"~/.config/eww/widgets/network/scripts/connect.sh '$safe_ssid'\"
                  (box :orientation \"h\" :spacing 12
                      (label :text \"$icon\")
                      (label :text \"$safe_ssid\")
                      (label :text \"$signal%\")
                  )
              )"
          done

          echo ")"
        '';
      };
      network_connect_sh = {
        target = "${scripts}/connect.sh";
        executable = true;
        text = ''
          #!/usr/bin/env bash

          TARGET="$1"

          if nmcli connection show "$TARGET" >/dev/null 2>&1; then
              nmcli connection up "$TARGET"
          else
              PASSWORD=$(wofi --dmenu --password --prompt "Wi-Fi Password")
              nmcli device wifi connect "$TARGET" password "$PASSWORD"
          fi
        '';
      };
      network_disconnect_sh = {
        target = "${scripts}/disconnect.sh";
        executable = true;
        text = ''
          #!/usr/bin/env bash

          nmcli connection down "$1"
        '';
      };
    };
  };
}