{ pkgs, ... }:

{
  systemd.user.services.firefox-daemon = {
    Unit = {
      Description = "Pre-load Firefox in background for fast startup";
      After = [ "graphical-session.target" ];
    };

    Service = {
      Type = "simple";
      ExecStart = "${pkgs.firefox}/bin/firefox --headless";
      Restart = "on-failure";
      TimeoutStartSec = "5";
    };

    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}