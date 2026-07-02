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
      "com.github.gabutakut.gabutdm"
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