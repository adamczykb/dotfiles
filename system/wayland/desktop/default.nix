{
  pkgs,
  config,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./gtk
  ];

  colorScheme = inputs.nix-colors.colorSchemes.everforest;

  environment.systemPackages =
    (import ./wrapped.nix {inherit pkgs inputs config;})
    ++ (with pkgs; [
      librewolf
      firefox
      libreoffice-fresh
      #     nicotine-plus
      inkscape
      pulseaudio
      gimp
    ]);
}
