{ config, pkgs, lib, inputs, ... }:

let
  users = import ./../../../../config/users.nix;
in
{
  imports = [
    inputs.dms.homeModules.dank-material-shell

    ./settings.nix
    ./clipboard-settings.nix

    ../../appearance/images
    ../../appearance/theme/breeze-dark.nix
    ../../appearance/theme/notwaita.nix
  ];

  home.file.".config/DankMaterialShell/plugin_settings.json".source = ./plugin_settings.json;

  programs.dank-material-shell = {
    enable = true;
    
    systemd = {
      enable = true;
      restartIfChanged = true; 
    };

    enableSystemMonitoring = true;
    enableVPN = true;
    enableDynamicTheming = true;
    enableAudioWavelength = true;
    enableCalendarEvents = true;

    session = {
      isLightMode = false;
      wallpaperPath = "/home/${users.default}/Pictures/shell-imgs/bg.png";
      wallpaperFillMode = "PreserveAspectCrop";
    };
  };
}