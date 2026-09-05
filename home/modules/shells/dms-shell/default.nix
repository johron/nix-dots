{ config, pkgs, lib, inputs, ... }:

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
    };
  };

  custom.hyprExtras = {
    shell = ''
      mainMod = "ALT"
      secMod = "SUPER"

      --hl.on("hyprland.start", function ()
      --    hl.exec_cmd("dms run")
      --end)

      hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("dms ipc spotlight toggle"))
      hl.bind(secMod .. " + V", hl.dsp.exec_cmd("dms ipc clipboard open"))
      hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("dms ipc powermenu open"))
      hl.bind("CONTROL + ALT + DELETE", hl.dsp.exec_cmd("dms ipc powermenu open"))
      hl.bind(secMod .. " + L", hl.dsp.exec_cmd("dms ipc lock lock"))
      hl.bind(secMod .. " + SHIFT + S", hl.dsp.exec_cmd("dms screenshot"))

      hl.bind("CONTROL + SHIFT + ESCAPE", hl.dsp.exec_cmd("dms ipc call processlist open"))
      hl.bind(secMod .. " + CONTROL + SHIFT + C", hl.dsp.exec_cmd("dms ipc color-picker toggle"))
    '';
  };
}