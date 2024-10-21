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
  };
}
