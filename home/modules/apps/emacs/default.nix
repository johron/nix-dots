{ pkgs, ... }:
{
  programs.emacs = {
    enable = true;
    
    extraPackages = epkgs: with epkgs; [
      all-the-icons-dired
      dired-open
      multiple-cursors
    ];

    extraConfig = builtins.readFile (./. + "/config/emacs.el");
  };

  services.emacs = {
    enable = true;
    socketActivation.enable = true; 
    startWithUserSession = "graphical";
  };
}
