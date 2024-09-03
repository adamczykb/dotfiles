{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    # inputs.home-manager.nixosModules.default
  ];

  # programs.zsh.enable = true;
  services.openssh = {
    enable = true;
    openFirewall = true;
    hostKeys = [
      {
        bits = 4096;
        path = "/etc/ssh/ssh_host_rsa_key";
        type = "rsa";
      }
      {
        path = "/etc/ssh/ssh_host_ed25519_key";
        type = "ed25519";
      }
    ];
  };
  # home-manager = {
  # extraSpecialArgs = {inherit inputs;};
  # users = {
  # "adamczykb" = import ../../shell/adamczykb.nix;
  # };
  # };
  users = {
    #mutableUsers = false;
    users = {
      # root.hashedPasswordFile = "/persist/secrets/root";
      adamczykb = {
        isNormalUser = true;
        description = "Bartosz Adamczyk";
        shell = let
          colors = config.colorScheme.palette;
        in
          pkgs.callPackage ../../shell {inherit pkgs inputs colors;};

        hashedPasswordFile = "/persist/secrets/adamczykb";
        extraGroups = [
          "wheel"
          "gitea"
          "docker"
          "systemd-journal"
          "audio"
          "plugdev"
          "wireshark"
          "video"
          "input"
          "lp"
          "networkmanager"
          "power"
          "nix"
          "adbusers"
          "libvirtd"
        ];
        uid = 1000;
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICVw2iutcGsoc+y9QkU0EJ7Sn0raIrGxNt4zdRdficKr adamczykb@perun"
        ];
      };

      # root = {
      #   openssh.authorizedKeys.keys = [
      #   ];
      #   shell = pkgs.bashInteractive;
      # };
    };
  };
}
