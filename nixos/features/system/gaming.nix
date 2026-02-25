{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris
    prismlauncher
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "org.vinegarhq.Sober"
    ];
  };

  programs.steam.enable = true;
}