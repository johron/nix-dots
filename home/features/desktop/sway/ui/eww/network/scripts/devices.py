#!/usr/bin/env python3

import subprocess

IGNORED_DEVICES = {
    "lo",
    "docker0",
}

IGNORED_PREFIXES = (
    "br-",
    "veth",
    "virbr",
    "tun",
    "tap",
)

IGNORED_TYPES = {
    "loopback",
    "bridge",
}

def devices() -> list:
    result = subprocess.run(
        [
            "nmcli",
            "-t",
            "-f",
            "DEVICE,TYPE,STATE,CONNECTION",
            "device",
            "status",
        ],
        text=True,
        capture_output=True,
        check=True,
    )

    devices = []

    for line in result.stdout.strip().splitlines():
        device, dev_type, state, connection = line.split(":", 3)

        # filter ignored device names
        if device in IGNORED_DEVICES:
            continue

        # filter virtual interface prefixes
        if any(device.startswith(prefix) for prefix in IGNORED_PREFIXES):
            continue

        # filter unwanted interface types
        if dev_type in IGNORED_TYPES:
            continue

        devices.append({
            "device": device,
            "type": dev_type,
            "state": state,
            "connection": None if connection == "--" else connection,
        })
    return devices

def wifi_enabled() -> bool:
    result = subprocess.run(
        ["nmcli", "radio", "wifi"],
        text=True,
        capture_output=True,
        check=True,
    )
    return result.stdout.strip() == "enabled"

def yuck() -> str:
    ret = r"""(box :orientation "v" :spacing 8"""

    ret += rf"""
    (box :orientation "h" :space-evenly false :spacing 16 :class "device-item"
        (label
            :class "device-icon"
            :text "{"airplanemode_inactive" if wifi_enabled() else "flight"}"
        )
        (box :orientation "v" :space-evenly true :spacing 2
            (label :class "device-name" :text "Airplane mode" :xalign 0)
        )
        (box :hexpand true)
        (checkbox
            :checked {str(not wifi_enabled()).lower()}
            :onunchecked "nmcli radio wifi on"
            :onchecked "nmcli radio wifi off"
        )
    )
    """

    for device in devices():
        safe_name = device["device"].replace('"', r'\"')
        signal_icon = "settings_input_antenna" if device["type"] == "wifi" else "lan"

        if device["state"] == "connected":
            ret += rf"""
            (box :orientation "h" :space-evenly false :spacing 16 :class "device-item"
                (label :class "device-icon" :text "{signal_icon}")
                (box :orientation "v" :space-evenly false :spacing 2
                    (label :class "device-name" :text "{safe_name}" :xalign 0)
                    (label :class "device-subtext" :text "Active" :xalign 0)
                )
                (box :hexpand true)
                (checkbox
                    :checked true
                    :onchecked "~/.config/eww/widgets/network/scripts/device_up.sh '{safe_name}'"
                    :onunchecked "~/.config/eww/widgets/network/scripts/device_down.sh '{safe_name}'"
                )
            )
            """
        else:
            ret += rf"""
            (box :orientation "h" :space-evenly false :spacing 16 :class "device-item"
                (label :class "device-icon" :text "{signal_icon}")
                (box :orientation "v" :space-evenly true :spacing 2
                    (label :class "device-name" :text "{safe_name}" :xalign 0)
                )
                (box :hexpand true)
                (checkbox
                    :checked false
                    :onchecked "~/.config/eww/widgets/network/scripts/device_up.sh '{safe_name}'"
                    :onunchecked "~/.config/eww/widgets/network/scripts/device_down.sh '{safe_name}'"
                )
            )
            """
    return ret + ")"

print(yuck())