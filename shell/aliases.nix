{pkgs, ...}: let
  inherit (pkgs.lib) getExe;
in rec {
  l = "${getExe pkgs.eza} --icons";
  e = "${getExe pkgs.eza} --icons -lha --git";

  g = "git";
  n = "nix";
  v = "nvim";

  ":q" = "exit";

  cat = "${getExe pkgs.bat} -p";
}
