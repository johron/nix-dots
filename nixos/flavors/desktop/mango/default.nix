{ config, pkgs, lib, inputs, ... }:

{
  imports = [
    inputs.mango.nixosModules.mango
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
  ];

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

  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];

    wlr.enable = true;

    config = {
      common = {
        "org.freedesktop.impl.portal.Screencast" = "mango";
        "org.freedesktop.impl.portal.Screenshot" = "mango";
      };
    };
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QT_QPA_PLATFORM = "wayland";
    XDG_CURRENT_DESKTOP = "mango";
    WLR_NO_HARDWARE_CURSORS = "1";
  };

  services.gnome.gnome-keyring.enable = true;
  security.pam.services.login.enableGnomeKeyring = true;
  security.pam.services.greetd.enableGnomeKeyring = true;

  security.pam.services.login.enableKwallet = true;

  systemd.user.services.gnome-keyring = {
    wantedBy = [ "default.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.gnome-keyring}/bin/gnome-keyring-daemon --start --foreground --components=pkcs11,secrets,ssh";
      Restart = "on-abort";
    };
  };

  programs.mango = {
    enable = true;
  };
}