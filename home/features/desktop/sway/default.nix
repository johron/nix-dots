{ pkgs, lib, ... }:

{
  imports = [
    ./sway.nix
    ./scripts.nix

    ./ui/eww
    ./ui/wofi
    ./ui/waybar
    ./ui/mako.nix
    
    ./theming/notwaita.nix
    ./theming/breeze-dark.nix
  ];

  home.packages = with pkgs; [
    material-symbols
    grim
    slurp
    swappy
  ];
}