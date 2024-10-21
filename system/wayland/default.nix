{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default
    ./fonts.nix
    ./services.nix
    ./pipewire.nix
    ../../services/default.nix
  ];
  environment = {
    variables = {
      NIXOS_OZONE_WL = "1";
      __GL_GSYNC_ALLOWED = "0";
      __GL_VRR_ALLOWED = "0";
      _JAVA_AWT_WM_NONEREPARENTING = "1";
      SSH_AUTH_SOCK = "/run/user/1000/keyring/ssh";
      DISABLE_QT5_COMPAT = "0";
      GDK_BACKEND = "wayland,x11";
      DIRENV_LOG_FORMAT = "";
      WLR_DRM_NO_ATOMIC = "1";
      QT_AUTO_SCREEN_SCALE_FACTOR = "1";
      QT_QPA_PLATFORM = "wayland";
      DISABLE_QT_COMPAT = "0";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      MOZ_ENABLE_WAYLAND = "0";
      WLR_BACKEND = "vulkan";
      WLR_RENDERER = "vulkan";
      XDG_SESSION_TYPE = "wayland";
      SDL_VIDEODRIVER = "wayland";
      XDG_CACHE_HOME = "/home/adamczykb/.cache";
      CLUTTER_BACKEND = "wayland";
    };
    loginShellInit = ''
    '';
    systemPackages = with pkgs; [
      pamixer
      brightnessctl
      kanshi
      gnome-control-center
      # screenshot
      overskride
      mission-center
      grim
      slurp

      # utils
      self.packages.${pkgs.system}.wl-ocr
      wl-clipboard
      wl-screenrec
      wlr-randr
    ];
  };

  colorScheme = inputs.nix-colors.colorSchemes.everforest;

  hardware = {
    graphics.enable = true;
    # pulseaudio.support32Bit = true;
  };
  # home.pointerCursor = {
  #   package = pkgs.bibata-cursors;
  #   name = "Bibata-Modern-Classic";
  #   size = 16;
  #   gtk.enable = true;
  #   x11.enable = true;
  # };
  # services.xserver.enable = true;
  # services.xserver.displayManager.gdm.enable = true;
  # services.xserver.desktopManager.gnome.enable = true;
  # xdg.portal = {
  # enable = true;
  # config.common.default = "*";
  # extraPortals = with pkgs; [
  # xdg-desktop-portal-gtk
  # ];
  # };
}
