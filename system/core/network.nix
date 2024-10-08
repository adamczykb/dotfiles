{
  pkgs,
  lib,
  config,
  ...
}: let
  dnscrypt = config.services.dnscrypt-proxy2.enable;
  inherit (lib) mkIf;
in {
  environment.systemPackages = with pkgs; [speedtest-cli];
  networking = {
    nameservers =
      if dnscrypt
      then ["127.0.0.1" "::1"]
      else ["192.168.88.1" "8.8.8.8"];
    dhcpcd.extraConfig = mkIf dnscrypt "nohook resolv.conf";
    networkmanager = {
      enable = true;
      unmanaged = ["docker0" "rndis0"];
      dns = mkIf dnscrypt "none";
      wifi = {
        macAddress = "random";
        powersave = true;
      };
    };
    firewall = {
      enable = true;
      allowPing = false;
      allowedUDPPorts = [];
      logReversePathDrops = true;
    };
    hosts = {
      "192.168.88.253" = ["www.bartekadamczyk.eu" "www.matrament.com"];
    };
  };

  # encrypted dns
  services.dnscrypt-proxy2 = {
    enable = true;
    settings = {
      ipv6_servers = true;
      require_dnssec = true;

      sources.public-resolvers = {
        urls = [
          "https://raw.githubusercontent.com/DNSCrypt/dnscrypt-resolvers/master/v3/public-resolvers.md"
          "https://download.dnscrypt.info/resolvers-list/v3/public-resolvers.md"
        ];
        cache_file = "/var/lib/dnscrypt-proxy2/public-resolvers.md";
        minisign_key = "RWQf6LRCGA9i53mlYecO4IzT51TGPpvWucNSCh1CBM0QTaLn73Y7GFO3";
      };
    };
  };

  # slows down boot time
  systemd.services.NetworkManager-wait-online.enable = false;
}
