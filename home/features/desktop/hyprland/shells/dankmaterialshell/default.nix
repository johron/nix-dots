{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.dms.homeModules.dank-material-shell
  ];

  home.packages = with pkgs; [
  ];

  home.file.".config/DankMaterialShell/settings.json".source = ./settings.json;
  home.file.".config/DankMaterialShell/clsettings.json".source = ./clsettings.json;
  home.file.".config/DankMaterialShell/plugin_settings.json".source = ./plugin_settings.json;

  programs.dank-material-shell = {
    enable = true;
    
    systemd = {
      enable = true;
      restartIfChanged = true; 
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
    '';
  };
}