{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    prismlauncher
    nvidia-vaapi-driver
    SDL2
    dualsensectl
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "org.vinegarhq.Sober"
      "org.vinegarhq.Vinegar"
      "io.github.C_Yassin.FlameGet"
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession = {
      enable = true;
    };
  };
}