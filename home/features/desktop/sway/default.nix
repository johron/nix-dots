{ pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
    ./scripts.nix

    ./ui/wofi
    ./ui/waybar
    ./ui/rofi.nix
    ./ui/mako.nix
    
    ./theming/notwaita.nix
    ./theming/breeze-dark.nix
  ];

  home.packages = with pkgs; [
    material-symbols
  ];
}