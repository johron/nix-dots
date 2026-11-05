{ config, pkgs, ... }:

{
  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [ "hwmon" "thermal_zone" ];
  };

  services.prometheus = {
    enable = true;
    scrapeConfigs = [
      {
        job_name = "nixos-server";
        static_configs = [
          {
            targets = [ "127.0.0.1:${toString config.services.prometheus.exporters.node.port}" ];
          }
        ];
      }
    ];
  };

  services.grafana = {
    enable = true;
    settings.server = {
      http_addr = "0.0.0.0";
      http_port = 3232;
    };
    settings.security.secret_key = "SW2YcwTIb9zpOOhoPsMm";
  };

}