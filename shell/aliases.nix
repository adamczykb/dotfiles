{pkgs, ...}: let
  inherit (pkgs.lib) getExe;
in rec {
  l = "${getExe pkgs.eza} --icons";
  e = "${getExe pkgs.eza} --icons -lha --git";

  ls = l;
  la = e;

  m = "mkdir -vp";

  g = "git";
  n = "nix";
  v = "nvim";

  ":q" = "exit";

  cat = "${getExe pkgs.bat} --plain";

  gcb = "git checkout";
  gd = "git pull";
  gu = "git push";
  gc = "git commit";
  ga = "git add";
}
