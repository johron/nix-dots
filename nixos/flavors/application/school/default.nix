{ config, pkgs, inputs, ... }:

{
  imports = [
    ./ntnu-vpn.nix
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