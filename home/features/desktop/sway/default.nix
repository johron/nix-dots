{ pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
    ./scripts.nix

    ./bg
    ./ui/eww
    ./ui/wofi
    ./ui/waybar
    ./ui/mako.nix
    
    ./theming/notwaita.nix
    ./theming/breeze-dark.nix
  ];

  home.packages = with pkgs; [
    grim
    slurp
    swappy
  ];
}