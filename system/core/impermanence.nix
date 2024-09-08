{
  inputs,
  lib,
  ...
}: let
  inherit (lib) forEach types mkOption;
in {
  imports = [inputs.impermanence.nixosModule];
  fileSystems."/etc/ssh" = {
    depends = ["/persist"];
    neededForBoot = true;
  };

  environment.persistence."/persist" = {
    hideMounts = true;
    directories =
      # persist directories in user directory (stolen from n3oney)
      builtins.map (v: {
        directory = "/home/adamczykb/${v}";
        user = "adamczykb";
        group = "users";
      }) (
        [
          ".thunderbird"
        ]
        ++ forEach [] (
          x: ".config/${x}"
        )
        ++ forEach ["tealdeer" "nix" "starship" "nix-index" "librewolf" "zsh" "nvim" "thunderbird"] (
          x: ".cache/${x}"
        )
        ++ forEach ["direnv" "keyrings" "nicotine" "zoxide"] (x: ".local/share/${x}")
        ++ [".ssh" ".librewolf"]
      )
      ++ [
        # dirty fix for "no storage left on device" while rebuilding
        # it gets wiped anyway
        "/tmp"
        "/var/log"
        "/var/db/sudo"
      ]
      ++ forEach ["nixos" "NetworkManager" "nix" "ssh" "secureboot"] (x: "/etc/${x}")
      ++ forEach ["bluetooth" "nixos" "pipewire" "libvirt" "fail2ban" "fprint"] (x: "/var/lib/${x}");
    files = ["/etc/machine-id"];
  };
  # for some reason *this* is what makes networkmanager not get screwed completely instead of the impermanence module
  systemd.tmpfiles.rules = [
    "L /var/lib/NetworkManager/secret_key - - - - /persist/var/lib/NetworkManager/secret_key"
    "L /var/lib/NetworkManager/seen-bssids - - - - /persist/var/lib/NetworkManager/seen-bssids"
    "L /var/lib/NetworkManager/timestamps - - - - /persist/var/lib/NetworkManager/timestamps"
  ];
}
