{
  pkgs,
  inputs,
  ...
}: {
  systemd.services = {
    # seatd = {
    #   enable = true;
    #   description = "Seat management daemon";
    #   script = "${pkgs.seatd}/bin/seatd -g wheel";
    #   serviceConfig = {
    #     Type = "simple";
    #     Restart = "always";
    #     RestartSec = "1";
    #   };
    #   wantedBy = ["multi-user.target"];
    # };
  };

  services = {
    # greetd = {
    #   enable = true;
    #   settings = rec {
    #     initial_session = {
    #       command = "river";
    #       user = "adamczykb";
    #     };
    #     default_session = initial_session;
    #     terminal.vt = 1;
    #   };
    # };

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
