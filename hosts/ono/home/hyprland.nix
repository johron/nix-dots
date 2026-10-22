{ config, pkgs, ... }: {
  imports = [
    ../../../home/modules/desktop/hyprland/modules/config-builder.nix
    ../../../home/modules/shells/dux-shell
    ../../../home/modules/shells/dux-shell/wm/hyprland
  ];

  programs.hyprlandLua = {
    enable = true;

    monitors = [
      { output = "eDP-1"; mode = "preferred"; position = "auto"; scale = 1; }
      { output = ""; mode = "preferred"; position = "auto"; scale = 1; mirror = "eDP-1"; }
    ];
  };
}