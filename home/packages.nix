{pkgs, ...}: {
  nixpkgs.config.allowUnfree = false;
  home.packages = with pkgs; [
  waybar
  libreoffice-fresh
    ledger-live-desktop
    ledger_agent
    tdesktop
    calcurse
    pulseaudio
    signal-desktop
    transmission-gtk
    gimp
    wireshark
    keepassxc
    dconf
  ];
}
