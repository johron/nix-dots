{ config, pkgs, ... }:
{
  imports = [
    
  ];

  environment.systemPackages = with pkgs; [
    cliphist
    wl-clipboard
    mission-center
    hyprpicker
    flameshot
    nomacs
    nemo
    gammastep
    geoclue2
  ];

  programs.sway = {
    enable = true;
    wrapperFeatures.gtk = true;
    extraPackages = with pkgs; [
      alacritty
      swaylock
      swayidle
      swaybg
    ];
  };

  programs.foot.enable = false;

  environment.variables = {
    GDK_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
  };

  security.pam.services.swaylock = {};
  services.gnome.gnome-keyring.enable = true;
}