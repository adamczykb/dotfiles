{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages = with pkgs; [
    clang
    cargo
    gcc
    haskellPackages.stack
    fzf
    openjdk17 # You can choose openjdk11, openjdk8, etc., based on your needs
    maven
  ];
}
