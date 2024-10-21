{
  config,
  pkgs,
  ...
}: {
  # light/dark specialisations
  # specialisation = let
  #   colorschemePath = "/org/gnome/desktop/interface/color-scheme";
  #   dconf = "${pkgs.dconf}/bin/dconf";

  #   dconfDark = lib.hm.dag.entryAfter ["dconfSettings"] ''
  #     ${dconf} write ${colorschemePath} "'prefer-dark'"
  #   '';
  #   dconfLight = lib.hm.dag.entryAfter ["dconfSettings"] ''
  #     ${dconf} write ${colorschemePath} "'prefer-light'"
  #   '';
  # in {
  #   light.configuration = {
  #     theme.name = "light";
  #     home.activation = {inherit dconfLight;};
  #   };
  #   dark.configuration = {
  #     theme.name = "dark";
  #     home.activation = {inherit dconfDark;};
  #   };
  # };

  theme = {
    wallpaper = let
      url = "https://www.bartekadamczyk.eu/share/wallpaper.png";
      sha256 = "8d74bc9759d560705985b56b18c670fc9f65c09266dafed7c84ba79ed693ca05";
      ext = "png";
    in
      builtins.fetchurl {
        name = "wallpaper-${sha256}.${ext}";
        inherit url sha256;
      };
  };

  programs.matugen = {
    enable = true;
    package = pkgs.matugen;
    inherit (config.theme) wallpaper;
  };
}
