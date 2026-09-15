{ inputs, pkgs, ... }: {
  imports = [
    inputs.mangowm.nixosModules.mango
  ];

  environment.systemPackages = with pkgs; [
    cliphist
    wl-clipboard
    hyprpicker
    wtype

    mission-center
    nomacs
    alacritty
    vlc

    kdePackages.kdenlive
    kdePackages.ark
    kdePackages.dolphin
    kdePackages.qtsvg 
    kdePackages.kio
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.ksshaskpass

    pam_u2f
  ];

  programs.mango.enable = true;
}