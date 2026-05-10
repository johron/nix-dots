#!/usr/bin/env python3

import subprocess

def get_connected() -> list:
    ret = []

    IGNORED_PREFIXES = ("lo", "docker", "br-", "veth", "virbr")
    IGNORED_TYPES = {"loopback", "bridge"}

    cmd = r"""
    nmcli -t -f DEVICE,TYPE,STATE,NAME connection show --active
    """
    connected = subprocess.run(
        cmd,
        shell = True,
        text = True,
        capture_output = True,
        check = True,
    )
    if connected.check_returncode():
        return

    for line in connected.stdout.strip().split("\n"):
        parts = line.split(":")

        device = parts[0]
        conn_type = parts[1]
        state = parts[2]
        name = parts[3]

        if conn_type in IGNORED_TYPES:
            continue

        if any(device.startswith(prefix) for prefix in IGNORED_PREFIXES):
            continue

        ret.append({
            "device": device,
            "type": conn_type,
            "state": state,
            "name": name,
        })
    return ret

def yuck() -> str:
    return get_connected()

if __name__ == "__main__":
    print(yuck())