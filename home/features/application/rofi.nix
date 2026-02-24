{ pkgs, lib, ... }:

let
  rofiRepo = builtins.fetchTarball {
    url = "https://github.com/johron/adi1090x-rofi/archive/refs/heads/master.tar.gz";
    sha256 = "02svplixyy6i3x28qjj0hb7lp4xl42a93iz342vibjz8665ajjwb";
  };
in
{
  programs.rofi = {
    enable = true;
    package = pkgs.rofi;
    theme = "launchers/type-4/style-5.rasi";
  };

  home = {
    file = {
      "/.config/rofi/launchers".source = "${rofiRepo}/files/launchers";
      "/.config/rofi/applets".source   = "${rofiRepo}/files/applets";
      "/.config/rofi/colors".source    = "${rofiRepo}/files/colors";
      "/.config/rofi/images".source    = "${rofiRepo}/files/images";
      "/.config/rofi/powermenu".source = "${rofiRepo}/files/powermenu";
      "/.config/rofi/scripts".source   = "${rofiRepo}/files/scripts";
    };
  };
}