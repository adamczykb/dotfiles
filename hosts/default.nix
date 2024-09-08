{
  nixpkgs,
  self,
  ...
}: let
  inherit (self) inputs;
  core = ../system/core;
  bootloader = ../system/core/bootloader.nix;
  impermanence = ../system/core/impermanence.nix;
  # server = ../system/server;
  wayland = ../system/wayland;
  hw = inputs.nixos-hardware.nixosModules;
  agenix = inputs.agenix.nixosModules.age;

  shared = [core agenix];
in {
  # thinkpad
  #  veles = nixpkgs.lib.nixosSystem {
  #    system = "x86_64-linux";
  #    modules =
  #      [
  #        {networking.hostName = "veles";}
  #        ./perun
  #        wayland
  #        bootloader
  #        impermanence
  #        hw.lenovo-thinkpad-x1-7th-gen
  #      ]
  #      ++ shared;
  #    specialArgs = {inherit inputs;};
  #  };

  # x86 GPU server
  perun = nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules =
      [
        {
          networking.hostName = "perun";
        }
        ./perun
        bootloader
        wayland
        inputs.home-manager.nixosModules.default
        # impermanence
        agenix
      ]
      ++ shared;
    specialArgs = {inherit inputs;};
  };
}
