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

    kitty
    alacritty

    hyprlauncher
  ];

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };

  programs.kdeconnect.enable = true;

  environment.variables = {
    GDK_BACKEND = "wayland";
    XDG_SESSION_TYPE = "wayland";
    WLR_DRM_NO_ATOMIC = "1";
    NIXOS_OZONE_WL = "1";
    WLR_RENDERER = "vulkan";
    WLR_NO_HARDWARE_CURSORS = "1";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  services.dbus.enable = true;
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];

    wlr.enable = true;

    config = {
      common = {
        # Use hyprland portal for screen sharing (screencast)
        "org.freedesktop.impl.portal.Screencast" = "hyprland";
        "org.freedesktop.impl.portal.Screenshot" = "hyprland";
      };
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "hyprland";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
}