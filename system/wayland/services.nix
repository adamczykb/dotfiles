{
  pkgs,
  inputs,
  ...
}: {
  systemd.services = {
  };

  services = {
    gnome.glib-networking.enable = true;
    logind = {
      lidSwitch = "suspend";
      lidSwitchExternalPower = "suspend";
      extraConfig = ''
        HandlePowerKey=suspend
        HibernateDelaySec=300
      '';
    };

    udisks2.enable = true;
    printing.enable = true;
    fstrim.enable = true;
    # needed for GNOME services outside of GNOME Desktop
    dbus.packages = with pkgs; [
      gcr
      gnome.gnome-settings-daemon
    ];

    gnome.gnome-keyring.enable = true;

    gvfs.enable = true;
  };
}
