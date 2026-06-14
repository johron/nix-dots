{ config, pkgs, lib, ... }:

let 
  customQuickshell = pkgs.symlinkJoin {
    name = "quickshell-wrapped";
    paths = [ pkgs.quickshell ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/qs \
        --prefix QML2_IMPORT_PATH : "${lib.makeSearchPath "lib/qt-6/qml" (with pkgs.kdePackages; [
          qtdeclarative
          qt5compat
          qtsvg
          qtimageformats
          qtmultimedia
        ])}"
    '';
  };
in
{
  imports = [
    ./hyprland.nix

    ./bg

    ./theming/notwaita.nix
    ./theming/breeze-dark.nix
  ];

  home.packages = [
    customQuickshell
  ];

  xdg.userDirs = {
    enable = true;
    createDirectories = true;
    
    documents = "$HOME/Documents";
    download = "$HOME/Downloads";
    desktop = "$HOME/Desktop";
    music = "$HOME/Music";
    pictures = "$HOME/Pictures";
    videos = "$HOME/Videos";
    projects = "$HOME/Projects";
  };
}