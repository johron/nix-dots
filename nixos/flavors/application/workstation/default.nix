{ config, pkgs, inputs, ... }:

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
    gparted
    dnsmasq
    pciutils
    python315
    playerctl
    p7zip-rar
    fastfetch
    pkg-config
    kdePackages.qt6ct
    lxqt.lxqt-policykit
    google-fonts
    ffmpeg_7-full
    discord
    proton-vpn
    cups-pk-helper
    dgop
    cava
    powertop
    spotify
    feishin
    obsidian
    inkscape
    f3d
    chromium
    mediawriter
  ];

  services.flatpak = {
    enable = true;
    packages = [
      "com.github.tchx84.Flatseal"
      "com.dec05eba.gpu_screen_recorder"
    ];
  };

  programs.librepods.enable = true;

  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      adwaita-fonts
      jetbrains-mono
      nerd-fonts.jetbrains-mono
      google-fonts
      material-symbols
      material-icons
    ];
    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Adwaita Sans" ];
        monospace = [ "JetBrains Mono" "Adwaita Mono" ];
      };
    };
  };

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt6ct";
    EDITOR = "nano";
  };

  services.xserver.xkb = {
    layout = "no";
    variant = "winkeys";
  };
  console.keyMap = "no";

  time.timeZone = "Europe/Oslo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nn_NO.UTF-8";
    LC_IDENTIFICATION = "nn_NO.UTF-8";
    LC_MEASUREMENT = "nn_NO.UTF-8";
    LC_MONETARY = "nn_NO.UTF-8";
    LC_NAME = "nn_NO.UTF-8";
    LC_NUMERIC = "nn_NO.UTF-8";
    LC_PAPER = "nn_NO.UTF-8";
    LC_TELEPHONE = "nn_NO.UTF-8";
    LC_TIME = "nn_NO.UTF-8";
  };

  security.polkit.enable = true;

  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [];
  };

  programs.firefox.enable = true;
  programs.noisetorch.enable = true;

  services.upower.enable = true;
  services.power-profiles-daemon.enable = true;

  services.accounts-daemon.enable = true;

  services.dbus = {
    enable = true;
    packages = with pkgs; [ cups-pk-helper ];
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "$HOME/nix-dots/";
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.seatd.enable = true;
  services.gvfs.enable = true;

  programs.virt-manager.enable = true;

  virtualisation = {
    libvirtd = {
      enable = true;
      qemu = {
        package = pkgs.qemu_kvm;
        vhostUserPackages = [ pkgs.virtiofsd ];
      };
    };
    docker = {
      enable = true;
      storageDriver = "btrfs";
    };
  };

  qt.enable = true;

  systemd.user.extraConfig = ''
    DefaultTimeoutStopSec=10s
  '';
}