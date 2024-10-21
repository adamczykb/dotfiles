{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  core = ../system/core;
  bootloader = ../system/core/bootloader.nix;
  impermanence = ../system/core/impermanence.nix;
  server = ../system/server;
  wayland = ../system/wayland;
  hw = inputs.nixos-hardware.nixosModules;
  agenix = inputs.agenix.nixosModules.age;

  shared = [core agenix];
in {
  #HP t630
  radegast = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "adamczykb-radegast";}
        #      ./radegast
        server
        bootloader
        impermanence
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
  # tkinkpad X1 carbon gen 5
  svetovid = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "adamczykb-svetovid";}
        # ./perun
        wayland
        bootloader
        impermanence
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
  # dell precision 7510
  veles = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {networking.hostName = "adamczykb-veles";}
        # ./perun
        wayland
        bootloader
        impermanence
        hw.dell-precission-7520
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };

  # x86 GPU server
  perun = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {
          networking.hostName = "adamczykb-perun";
        }
        ./perun
        bootloader
        wayland
        inputs.home-manager.nixosModules.default
        # impermanence
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
}
