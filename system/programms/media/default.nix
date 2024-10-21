{pkgs, ...}: {
  imports = [
  ];

  environment.systemPackages = with pkgs; [
    # audio control
    pulsemixer
    pwvucontrol

    # audio
    amberol
    spotify

    # images
    loupe

    # videos
    celluloid
  ];
}
