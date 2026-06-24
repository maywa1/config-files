{ config, ... }: {

  powerManagement = {
    enable = true;
  };

  services = {
    upower = {
      enable = true;
      criticalPowerAction = "Hibernate";
    };

    # Keep auto-cpufreq as your SINGLE source of truth for CPU power management
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance";
          turbo = "auto";
        };
      };
    };

  };
}
