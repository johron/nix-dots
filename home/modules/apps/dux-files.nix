{ pkgs, inputs, ... }:

{
  imports = [
    inputs.dux-files.homeModules.default
  ];

  programs.dux-files = {
    enable = true;

    systemd = {
      enable = true;
      target = "graphical-session.target";
      restartIfChanged = true;
    };

    settings = {
      themeMode = "dark";
      radiusStrength = 50;
      defaultView = "list";
      vimKeys = false;
    };

    portal = {
      enable = true;
      preferred = true;
      desktop = "hyprland";
    };
  };
}