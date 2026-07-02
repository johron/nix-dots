{ config, pkgs, inputs, ... }:

{
  environment.systemPackages = with pkgs; [];

  services.flatpak = {
    packages = [
      "org.geogebra.GeoGebra"
    ];
  };
}