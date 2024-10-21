{
  services.gammastep = {
    enable = true;
    tray = true;

    # stopgap until geoclue's wifi location is fixed
    provider = "manual";
    latitude = 52.0;
    longitude = 16.0;

    enableVerboseLogging = true;

    settings.general.adjustment-method = "wayland";
  };
}

