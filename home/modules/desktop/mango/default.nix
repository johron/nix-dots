{ config, pkgs, lib, inputs, host, ... }:

{
  imports = [
    inputs.mangowm.hmModules.mango
  ];

  wayland.windowManager.mango = {
    enable = true;
    settings = {
      blur = 0;
      blur_optimized = 0;
      border_radius = 0;
      focused_opacity = 1.0;
      unfocused_opacity = 1.0;

      animations = 0;
      animation_type_open = "slide";
      animation_type_close = "slide";
      animation_duration_open = 200;
      animation_duration_close = 200;

      bind = [
        "SUPER,r,reload_config"
        "ALT,space,spawn,rofi -show drun"
        "ALT,Return,spawn,alacritty"
        "ALT,SHIFT,Q,close"
        "ALT,P,pseudo"
        "ALT,F,fullscreen"
        "ALT,SHIFT,SPACE,float"
        "SUPER,E,spawn,dolphin"
        "SUPER,Q,spawn,firefox"
        "SUPER,S,spawn,spotify"
        "SUPER,D,spawn,vesktop"
        "ALT,Left,focus,left"
        "ALT,Right,focus,right"
        "ALT,Up,focus,up"
        "ALT,Down,focus,down"
        "ALT,SHIFT,Left,movewin,left"
        "ALT,SHIFT,Right,movewin,right"
        "ALT,SHIFT,Up,movewin,up"
        "ALT,SHIFT,Down,movewin,down"
        "ALT,1,focus,1"
        "ALT,2,focus,2"
        "ALT,3,focus,3"
        "ALT,4,focus,4"
        "ALT,5,focus,5"
        "ALT,6,focus,6"
        "ALT,7,focus,7"
        "ALT,8,focus,8"
        "ALT,9,focus,9"
        "ALT,0,focus,10"
        "ALT,SHIFT,1,movetag,1"
        "ALT,SHIFT,2,movetag,2"
        "ALT,SHIFT,3,movetag,3"
        "ALT,SHIFT,4,movetag,4"
        "ALT,SHIFT,5,movetag,5"
        "ALT,SHIFT,6,movetag,6"
        "ALT,SHIFT,7,movetag,7"
        "ALT,SHIFT,8,movetag,8"
        "ALT,SHIFT,9,movetag,9"
        "ALT,SHIFT,0,movetag,10"
        "ALT,F1,focus,11"
        "ALT,F2,focus,12"
        "ALT,SHIFT,F1,movetag,11"
        "ALT,SHIFT,F2,movetag,12"
        "ALT,R,setkeymode,resize"
      ];

      tagrule = [
        "id:1,layout_name:tile"
        "id:2,layout_name:scroller"
        "class:vesktop,workspace:11"
        "class:spotify,workspace:12"
      ];

      keymode = {
        resize = {
          bind = [
            "NONE,Left,resizewin,-10,0"
            "NONE,Right,resizewin,10,0"
            "NONE,Up,resizewin,0,-10"
            "NONE,Down,resizewin,0,10"
            "NONE,Escape,setkeymode,default"
          ];
        };
      };
    };
  };
}