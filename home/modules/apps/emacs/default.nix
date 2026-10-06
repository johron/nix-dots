{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs;
    
    extraPackages = epkgs: [
    ];

    extraConfig = builtins.readFile ./config/emacs.el;
  };

  services.emacs = {
    enable = true;
    package = pkgs.emacs;
    socketActivation.enable = true; # Starts Emacs on demand when emacsclient is called
    startWithUserSession = "graphical"; # Launch with graphical session or true for default.target
  };
}