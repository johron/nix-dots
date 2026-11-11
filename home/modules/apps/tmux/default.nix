{
  config,
  pkgs,
  lib,
  ...
}:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    extraConfig = ''
      bind | split-window -h -c "#{pane_current_path}"
      bind - split-window -v -c "#{pane_current_path}"
      bind % split-window -h -c "#{pane_current_path}"
      bind '"' split-window -v -c "#{pane_current_path}"

      bind c new-window -c "#{pane_current_path}"

      set -as terminal-features ",alacritty:RGB:sync"
      set -ga terminal-overrides ",*256col*:Tc"
      set -g mouse on
    '';
  };

  systemd.user.services.tmux-autokill = {
    Unit.Description = "Kill tmux sessions idle for more than 30 minutes";
    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.writeShellScript "tmux-autokill" ''
        NOW=$(${pkgs.coreutils}/bin/date +%s)
        THRESHOLD=30
        ${pkgs.tmux}/bin/tmux list-sessions -F '#{session_name} #{session_activity}' 2>/dev/null | while read -r name activity; do
            IDLE_MINUTES=$(( (NOW - activity) / 60 ))
            if [ "$IDLE_MINUTES" -ge "$THRESHOLD" ]; then
                ${pkgs.tmux}/bin/tmux kill-session -t "$name"
            fi
        done
      ''}";
    };
  };

  systemd.user.timers.tmux-autokill = {
    Unit.Description = "Run tmux autokill every 5 minutes";
    Timer = {
      OnBootSec = "2m";
      OnUnitActiveSec = "5m";
    };
    Install.WantedBy = [ "timers.target" ];
  };
}
