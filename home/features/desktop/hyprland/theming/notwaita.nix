{ pkgs, lib, ... }:

let
  notwaitaBlackSrc = pkgs.fetchurl {
    url = "https://github.com/ful1e5/notwaita-cursor/releases/download/v1.0.0-alpha1/Notwaita-Black.tar.xz";
    sha256 = "sha256-P/F4NRBqz/6Ws9//qEKMYdqtfG5LdZa6jihqueZnx88==";
  };

  notwaitaBlackCursor = pkgs.runCommand "notwaita-black-cursor" {
    nativeBuildInputs = [ pkgs.xz pkgs.gnutar ];
  } ''
    mkdir -p $out/share/icons
    tar -xJf ${notwaitaBlackSrc} -C $out/share/icons
  '';
in
{
  home = {
    pointerCursor = {
      package = notwaitaBlackCursor;
      name = "Notwaita-Black";
      size = 20; # adjust size you want
      gtk.enable = true;
      x11.enable = true;
    };
  };
}