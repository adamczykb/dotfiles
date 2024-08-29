{
  pkgs,
  inputs,
  ...
}: {
  environment.systemPackages =
    (with pkgs; [
      clang
      cargo
      gcc
    ])
    ++ [
      inputs.zig-overlay.packages.${pkgs.system}.master
    ];
}
