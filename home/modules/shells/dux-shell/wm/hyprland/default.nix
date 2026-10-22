{ config, pkgs, ... }: {
  imports = [ ../../../../../../home/modules/desktop/hyprland/modules/config-builder.nix ];

  programs.hyprlandLua = {
    shellCommand = "dms run";

    bindings = [
      { key = "ALT + D"; action = ''hl.dsp.exec_cmd("dms ipc spotlight toggle")''; }
      { key = "SUPER + V"; action = ''hl.dsp.exec_cmd("dms ipc clipboard open")''; }
      { key = "ALT + SHIFT + E"; action = ''hl.dsp.exec_cmd("dms ipc powermenu open")''; }
      { key = "CONTROL + ALT + DELETE"; action = ''hl.dsp.exec_cmd("dms ipc powermenu open")''; }
      { key = "SUPER + L"; action = ''hl.dsp.exec_cmd("dms ipc lock lock")''; }
      { key = "SUPER + SHIFT + S"; action = ''hl.dsp.exec_cmd("dms screenshot")''; }
      { key = "CONTROL + SHIFT + ESCAPE"; action = ''hl.dsp.exec_cmd("dms ipc call processlist open")''; }
      { key = "SUPER + CONTROL + SHIFT + C"; action = ''hl.dsp.exec_cmd("dms ipc color-picker toggle")''; }
    ];
  };
}