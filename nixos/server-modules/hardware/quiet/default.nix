{ config, pkgs, ... }:

{
  systemd.tmpfiles.rules = [
    "w /sys/firmware/acpi/platform_profile - - - - quiet"
    "w /sys/devices/system/cpu/intel_pstate/no_turbo - - - - 1"
    "w /sys/devices/system/cpu/cpu*/cpufreq/energy_performance_preference - - - - power"
  ];

  powerManagement.cpuFreqGovernor = "powersave";

  # Optional: cap max CPU performance (try 50-70 for a mostly idle server)
  # systemd.tmpfiles.rules = [ "w /sys/devices/system/cpu/intel_pstate/max_perf_pct - - - - 60" ];

  services.thermald.enable = true;

  # boot.kernelParams = [ "consoleblank=60" ];
}