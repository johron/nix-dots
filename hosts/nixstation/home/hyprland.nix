{ config, pkgs, ... }: {
  imports = [
    ../../../home/modules/desktop/hyprland/modules/config-builder.nix
    ../../../home/modules/shells/dms-shell
    ../../../home/modules/shells/dms-shell/wm/hyprland
  ];

  programs.hyprlandLua = {
    enable = true;

    monitors = [
      { output = "DP-1"; mode = "1920x1080@143.98"; position = "0x0"; scale = 1; }
      { output = "HDMI-A-1"; mode = "1920x1080@143.98"; position = "1920x0"; scale = 1; }
      { output = ""; mode = "preferred"; position = "auto"; scale = 1; }
    ];

    workspaceRules = [
      { startIdx = 1; endIdx = 10; formula = "i % 10"; monitor = "DP-1"; default = true; }
      { startIdx = 11; endIdx = 20; formula = "i"; monitor = "HDMI-A-1"; default = true; }
    ];

    defaultCursorMonitor = "DP-2";
  };
}