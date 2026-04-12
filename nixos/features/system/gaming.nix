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
      "org.vinegarhq.Vinegar"
    ];
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    gamescopeSession = {
      enable = true;
    };
    extraCompatPackages = with pkgs; [
      gtk2
      gdk-pixbuf
      libpulseaudio
      pipewire
      bzip2
      xorg.libXtst
      xorg.libXi
      xorg.libXrandr
      xorg.libXrender
      libvdpau
      freetype
      proton-ge-bin
    ];
  };
}