{
  config,
  lib,
  ...
}: let
  forHost = hostnames: secretFile: secretName: extra:
    lib.mkIf (builtins.elem config.networking.hostName hostnames) {
      ${secretName} =
        {
          file = secretFile;
        }
        // extra;
    };

  user = {
    owner = "adamczykb";
    group = "users";
  };
in {
  age.secrets = lib.mkMerge [
  ];
  # age.secrets.syncthing-key = {
  #   file = syncthing-key.age;
  #   owner = "adamczykb";
  #   group = "users";
  # };
  # age.secrets.syncthing-cert = {
  #   file = ../../secrets/syncthing-cert.age;
  #   owner = "adamczykb";
  #   group = "users";
  # };
}
