{
  pkgs,
  inputs,
  config,
  ...
}: {
  imports = [
    inputs.home-manager.nixosModules.default
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
      root.hashedPasswordFile = "/persist/secrets/root";
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
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE9ExEl6WqtCI4yCqbSAhAGmzvVp/nYADbgy/Qi4AKQy sioodmy@anthe"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+S9LPxp3Mmha1keHlwc0iVq4CMbHvzAAwuYE2go7io sioodmy@calypso"
        ];
      };

      root = {
        openssh.authorizedKeys.keys = [
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE9ExEl6WqtCI4yCqbSAhAGmzvVp/nYADbgy/Qi4AKQy sioodmy@anthe"
          "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIH+S9LPxp3Mmha1keHlwc0iVq4CMbHvzAAwuYE2go7io sioodmy@calypso"
        ];
        shell = pkgs.bashInteractive;
      };
    };
  };
}
