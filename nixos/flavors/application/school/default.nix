{ config, pkgs, inputs, ... }:

{
  imports = [
    ./ntnu-vpn.nix
    #./smb4k.nix # fungerer ikkje
  ];

  environment.systemPackages = with pkgs; [
    geteduroam
  ];

  services.flatpak = {
    packages = [
      "org.geogebra.GeoGebra"
      "org.remmina.Remmina"
    ];
  };
}