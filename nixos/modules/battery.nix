{ config, ... }: {

  powerManagement = {
    enable = true;
  };

  services = {

    # Keep auto-cpufreq as your SINGLE source of truth for CPU power management
    auto-cpufreq = {
      enable = true;
      settings = {
        battery = {
          governor = "powersave";
          turbo = "never";
        };
        charger = {
          governor = "performance"; # CHANGED: Prevents the "laggy" feeling when plugged in
          turbo = "auto";
        };
      };
    };

  };
}
