{
  config,
  lib,
  ...
}: {
  programs.alacritty = {
    enable = true;
    settings = {
      window.dimensions = {
        lines = 3;
        columns = 200;
      };
      keyboard.bindings = [
        {
          key = "K";
          mods = "Control";
          chars = "\\u000c";
        }
      ];
      font = {
        normal = {
          family = "Iosevka Term";
          style = "monospace";
        };
      };
      background_opacity = 0.95;
      env = {"TERM" = "xterm-256color";};
      shell = "devenv";
    };
  };
}
