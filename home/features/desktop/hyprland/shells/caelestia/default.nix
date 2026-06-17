{ config, pkgs, lib, inputs, ... }:

{
  home.packages = [
    inputs.caelestia-shell.packages.${pkgs.system}.default
    inputs.caelestia-cli.packages.${pkgs.system}.default
  ];

  home.file.".config/caelestia/shell.json".source = ./shell.json;
  home.file.".config/caelestia/shell-tokens.json".source = ./shell-tokens.json;

  custom.hyprExtras = {
    shell = ''
      mainMod = "ALT"
      secMod = "SUPER"

      hl.on("hyprland.start", function ()
        hl.exec_cmd("caelestia shell")
        hl.exec_cmd("caelestia shell wallpaper set ~/.config/caelestia/img/bg.png")
        hl.exec_cmd("caelestia scheme set --name dynamic --mode dark")
        hl.exec_cmd("wl-paste --watch cliphist store")
      end)

      hl.bind(mainMod .. " + E",  hl.dsp.exec_cmd("caelestia shell drawers toggle sidebar"))
      hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exec_cmd("caelestia shell drawers toggle session"))
      hl.bind("CONTROL + ALT + DELETE", hl.dsp.exec_cmd("caelestia shell drawers toggle session"))
      hl.bind(secMod .. " + V", hl.dsp.exec_cmd("caelestia clipboard"))
      hl.bind(secMod .. " + L",  hl.dsp.exec_cmd("caelestia shell lock lock"))

      hl.bind(secMod .. " + SHIFT + S", hl.dsp.exec_cmd([[
        #!/bin/bash
        OLD=$(wl-paste)
        caelestia shell picker openFreezeClip

        for i in {1..20}; do
          NEW=$(wl-paste)
          
          if [ "$NEW" != "$OLD" ]; then
            wl-paste --type image/png > ~/Pictures/Screenshots/$(date +%Y-%m-%d_%H-%M-%S).png
            exit 0
          fi

          sleep 0.1
        done

        exit 1
      ]]))
    '';
  };
}