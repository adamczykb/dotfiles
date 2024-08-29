{
  pkgs,
  inputs,
  config,
  ...
}: let
  inherit (config.age) secrets;
in
  # TODO
  {
    imports = [
    ];

    services = {
    };

    networking.firewall = {
      # allowedTCPPorts = [80 443];
    };
  }
