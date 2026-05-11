#!/usr/bin/env python3

import subprocess
import sys
from pathlib import Path

script_dir = Path(__file__).parent
sys.path.insert(0, str(script_dir))

from connected import get_connected

def get_networks() -> list:
    ret = []
    cmd = r"""
    nmcli -t -f SSID,SIGNAL,SECURITY,DEVICE,ACTIVE dev wifi list \
    | sort -t: -k1,1 -k2,2nr \
    | awk -F: '!seen[$1]++'
    """
    wifi = subprocess.run(
        cmd,
        shell = True,
        text = True,
        capture_output = True,
        check = True,
    )
    if wifi.check_returncode():
        return

    for line in wifi.stdout.strip().split("\n"):
        parts = line.split(":")

        ssid = parts[0]
        if ssid == "":
            continue
        signal = parts[1]
        if signal == "" or not int(signal):
            continue
        security = parts[2]
        if security == "":
            continue
        device = parts[3]
        if device == "":
            continue
        active = parts[4]
        if active == "":
            continue

        ret.append({
            "name": ssid,
            "type": "802-11-wireless",
            "signal": int(signal),
            "security": security,
            "device": device,
            "active": True if active == "yes" else False
        })
    return ret

def get_available() -> list:
    available_networks = get_networks()
    available_networks = sorted(available_networks, key=lambda x: (0 if x["active"] else 1, -x["signal"]))
    return available_networks

def signal_to_bars(signal: int) -> str:
    if signal > 83:
        return "signal_wifi_4_bar"
    if signal >= 66:
        return "network_wifi"
    elif signal >= 49:
        return "network_wifi_3_bar"
    elif signal >= 32:
        return "network_wifi_2_bar"
    elif signal >= 15:
        return "network_wifi_1_bar"
    else:
        return "signal_wifi_0_bar"
    
def yuck() -> str:
    available = get_available()
    ret = r"""(box :orientation "v" :spacing 8"""

    for connection in available:
        signal_icon = signal_to_bars(connection["signal"])
        safe_name = connection["name"].replace('"', r'\"')
        
        if connection["active"]:
            ret += rf"""
            (button
                :class "network-item active"
                :onclick "~/.config/eww/widgets/network/scripts/disconnect_wifi.sh '{safe_name}'"
                (box :orientation "h" :space-evenly false :spacing 16
                    (label :class "network-icon" :text "{signal_icon}")
                    (box :orientation "v" :space-evenly false :spacing 2
                        (label :class "network-name" :text "{safe_name}" :xalign 0)
                        (label :class "network-subtext" :text "Connected" :xalign 0)
                    )
                    (box :hexpand true)
                )
            )
            """
        else:
            ret += rf"""
            (button
                :class "network-item"
                :onclick "~/.config/eww/widgets/network/scripts/connect_wifi.sh '{safe_name}'"
                (box :orientation "h" :space-evenly false :spacing 16
                    (label :class "network-icon" :text "{signal_icon}")
                    (box :orientation "v" :space-evenly true :spacing 2
                        (label :class "network-name" :text "{safe_name}" :xalign 0)
                    )
                    (box :hexpand true)
                )
            )
            """
    
    return ret + ")"

if __name__ == "__main__":
    print(yuck())