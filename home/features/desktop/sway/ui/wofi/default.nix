{ pkgs, lib, ... }:

{
  imports = [
    ./style.nix
  ];

  programs.wofi = {
    enable = true;
    settings = {
      location = "center";
      width = 600;
      height = 350;
      allow_images = true;
      gtk_dark = true;
      no_actions = true;
      term = "alacritty";
      prompt = "drun";
      show = "drun";
      insensitive = true;
      matching = "fuzzy";
    };
  };
}