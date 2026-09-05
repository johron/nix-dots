mainMod = "ALT"
secMod = "SUPER"

hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("dms ipc spotlight toggle"))
hl.bind(secMod .. " + V", hl.dsp.exec_cmd("dms ipc clipboard open"))
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("dms ipc powermenu open"))
hl.bind("CONTROL + ALT + DELETE", hl.dsp.exec_cmd("dms ipc powermenu open"))
hl.bind(secMod .. " + L", hl.dsp.exec_cmd("dms ipc lock lock"))
hl.bind(secMod .. " + SHIFT + S", hl.dsp.exec_cmd("dms screenshot"))

hl.bind("CONTROL + SHIFT + ESCAPE", hl.dsp.exec_cmd("dms ipc call processlist open"))
hl.bind(secMod .. " + CONTROL + SHIFT + C", hl.dsp.exec_cmd("dms ipc color-picker toggle"))