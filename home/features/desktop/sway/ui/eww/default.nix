{ pkgs, lib, ... }:
{
  imports = [
    ./network
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
        '';
      };
      eww_scss = {
        target = ".config/eww/eww.scss";
        text = ''
          
        '';
      };
    };
  };
}