{
  pkgs,
  colors,
  ...
}: let
  theme = pkgs.writeText "andromeda.rasi" (import ./rasi.nix {inherit colors;});
in {
  basePackage = pkgs.rofi-wayland.override {
    plugins = with pkgs; [
      (rofi-calc.override {
        rofi-unwrapped = rofi-wayland-unwrapped;
      })
      (rofi-emoji.override {
        rofi-unwrapped = rofi-wayland-unwrapped;
      })
    ];
  };
  flags = [
    "-theme"
    "${theme}"
    "-combi-modi"
    "drun,emoji,calc"
  ];
  renames = {
    "rofi" = "launcher";
  };
}
