{ config, pkgs, lib, inputs, host, ... }:

{
  wayland.windowManager.mango = {
    settings = {
      bind = [
        "SUPER,r,reload_config"
        "Alt,space,spawn,rofi -show drun"
        "Alt,Return,spawn,foot"
        "ALT,R,setkeymode,resize"
      ];
    };
  };
}