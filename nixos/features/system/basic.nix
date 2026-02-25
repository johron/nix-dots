{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    lf
    jq
    gh
    git
    wget
    wine
    curl
    htop
    unzip
    seatd
    libgcc
    gnumake
    gparted
    dnsmasq
    pciutils
    onefetch
    python315
    playerctl
    p7zip-rar
    fastfetch
    pkg-config
    kdePackages.qt6ct
    lxqt.lxqt-policykit
    xdg-desktop-portal-wlr
  ];

  fonts = {
    packages = with pkgs; [
      adwaita-fonts
      jetbrains-mono
      nerd-fonts.jetbrains-mono
    ];
    fontconfig = {
      defaultFonts = {
        sansSerif = [ "Adwaita Sans" ];
        monospace = [ "JetBrains Mono" "Adwaita Mono" ];
      };
    };
  };

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
  };

  services.xserver.xkb = {
    layout = "no";
    variant = "winkeys";
  };
  console.keyMap = "no";

  time.timeZone = "Europe/Oslo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nb_NO.UTF-8";
    LC_IDENTIFICATION = "nb_NO.UTF-8";
    LC_MEASUREMENT = "nb_NO.UTF-8";
    LC_MONETARY = "nb_NO.UTF-8";
    LC_NAME = "nb_NO.UTF-8";
    LC_NUMERIC = "nb_NO.UTF-8";
    LC_PAPER = "nb_NO.UTF-8";
    LC_TELEPHONE = "nb_NO.UTF-8";
    LC_TIME = "nb_NO.UTF-8";
  };

  security.polkit.enable = true;

  programs.nix-ld.enable = true;

  programs.firefox.enable = true;

  services.seatd.enable = true;
  services.gvfs.enable = true;
  services.flatpak.enable = true;

  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  virtualisation.docker.enable = true;
  virtualisation.docker.storageDriver = "btrfs";
}