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

def yuck() -> str:
    available = get_available()
    ret = r"""(box :orientation "v" :spacing 2"""

    for connection in available:
        icon = ""
        if connection["type"] == "802-11-wireless":
            icon = "w" # legg inn ikon etter signal strength
        elif connection["type"] == "802-3-ethernet":
            icon = "e"
        elif connection["type"] == "vpn":
            icon = "v"
        else:
            icon = "?"
        
        safe_name = connection["name"].replace('"', r'\"')

        if connection["active"] == True:
            ret += rf"""
            (button
                :class "active-wifi"
                :onclick "~/.config/eww/widgets/network/scripts/disconnect_wifi.sh"
            """
        else:
            ret += rf"""
            (button
                :class "inactive-wifi"
                :onclick "~/.config/eww/widgets/network/scripts/connect_wifi.sh"
            """
        ret += rf"""
                (box :orientation "h" :height 32 :spacing 2
                    (label :text "{icon}")
                    (label :text "{safe_name}")
                )
            )
        """
    return ret + ")"

if __name__ == "__main__":
    print(yuck())

