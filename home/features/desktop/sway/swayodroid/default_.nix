{ config, pkgs, lib, ... }:

let
  swayodroid-shell = pkgs.fetchFromGitHub {
    owner = "johron";
    repo = "swayodroid-shell";
    rev = "main"; 
    hash = "sha256-bFQp3EnWMxaadviMtDCbReveJBVFUqmSp68L8825KIU=";
  };

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

  programs.quickshell = {
    enable = true;
    package = customQuickshell;
  };

  home.file.".config/quickshell/swayodroid".source = swayodroid-shell;
}