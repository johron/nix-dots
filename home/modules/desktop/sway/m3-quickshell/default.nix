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
  home.packages = [
    customQuickshell
  ];

  #programs.quickshell = {
  #  enable = true;
  #  configs.m3 = ./.;
  #  activeConfig = "m3";
  #};
}