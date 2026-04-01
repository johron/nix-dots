{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    lutris
    prismlauncher
    nvidia-vaapi-driver
    steam
    SDL2
    dualsensectl
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "org.vinegarhq.Sober"
    ];
  };

  programs.steam = {
    enable = true;
  };
}