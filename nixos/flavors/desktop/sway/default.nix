{ config, pkgs, ... }:
{
  imports = [
    
  ];

  environment.systemPackages = with pkgs; [
    cliphist
    wl-clipboard
    mission-center
    hyprpicker
    nomacs
    gammastep
    geoclue2
    wtype
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

  xdg.portal = {
    enable = true;

    wlr.enable = true;

    extraPortals = with pkgs; [
      xdg-desktop-portal-wlr
    ];
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "sway";
  };

  security.pam.services.swaylock = {};
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
}