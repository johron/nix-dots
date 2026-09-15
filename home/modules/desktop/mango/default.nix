{ config, pkgs, lib, inputs, host, ... }:

{
  imports = [
    #./bind.nix
  ];

  wayland.windowManager.mango = {
    enable = true;
    settings = {
      blur = 1;
      blur_optimized = 1;
      blur_params = {
        radius = 5;
        num_passes = 2;
      };
      border_radius = 6;
      focused_opacity = 1.0;

      animations = 1;
      animation_type_open = "slide";
      animation_type_close = "slide";
      animation_duration_open = 400;
      animation_duration_close = 800;

      animation_curve = {
        open = "0.46,1.0,0.29,1";
        close = "0.08,0.92,0,1";
      };

      bind = [
        "SUPER,r,reload_config"
        "Alt,space,spawn,rofi -show drun"
        "Alt,Return,spawn,foot"
        "ALT,R,setkeymode,resize"
      ];

      tagrule = [
        "id:1,layout_name:tile"
        "id:2,layout_name:scroller"
      ];

      keymode = {
        resize = {
          bind = [
            "NONE,Left,resizewin,-10,0"
            "NONE,Escape,setkeymode,default"
          ];
        };
      };
    }

  };
}