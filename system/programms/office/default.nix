{pkgs, ...}: {
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    obsidian
    rnote
    libreoffice-fresh
    inkscape
    krita
  ];
}
