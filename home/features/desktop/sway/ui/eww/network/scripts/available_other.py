def get_wired() -> list:
    ret = []
    cmd = r"""
    nmcli -t -f DEVICE,TYPE,STATE,CONNECTION device status | grep ethernet
    """
    eth = subprocess.run(
        cmd,
        shell = True,
        text = True,
        capture_output = True,
        check = True,
    )
    if eth.check_returncode():
        return
    
    for line in eth.stdout.strip().split("\n"):
        parts = line.split(":")

        device = parts[0]
        if device == "":
            continue
        typ = parts[1]
        if typ == "":
            continue
        state = parts[2]
        if state == "" or state == "unavailable":
            continue
        connection = parts[3]
        if connection == "":
            continue
        
        ret.append({
            "device": device,
            "type": typ,
            "state": state,
            "name": connection,
        })
    return ret