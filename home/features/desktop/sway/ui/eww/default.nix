{ pkgs, lib, ... }:
{
  imports = [
    ./network
    ./calendar
  ];

  programs.eww = {
    enable = true;
  };

  home = {
    file = {
      eww_yuck = {
        target = ".config/eww/eww.yuck";
        text = ''
          (include "./widgets/network/network.yuck")
          (include "./widgets/calendar/calendar.yuck")
        '';
      };
      eww_scss = {
        target = ".config/eww/eww.scss";
        text = ''
          @import "widgets/network/network.scss";
          @import "widgets/calendar/calendar.scss";

          * {
            border: none;
            font-family: "JetBrainsMono Nerd Font", "Material Symbols Outlined";
            font-size: 12px;
            font-weight: 700;
          }
        '';
      };
    };
  };
}