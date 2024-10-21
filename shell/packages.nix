{pkgs, ...}:
with pkgs; [
  zoxide

  eza

  # Tbh should be preinstalled
  # gnumake
  # Runs programs without installing them
  comma

  # grep replacement
  ripgrep

  # ping, but with cool graph
  gping

  # neofetch but for git repos
  onefetch

  git

  # man pages for tiktok attention span mfs
  tealdeer

  # markdown previewer
  glow

  # profiling tool
  hyperfine

  # gimp for acoustic people
  imagemagick

  # premiere pro for acoustic people
  ffmpeg-full

  # preview images in terminal
  catimg

  # networking stuff
  nmap
  wget

  # faster find
  fd

  # http request thingy
  xh

  # generate regex
  grex

  # json thingy
  jq

  # docs
  pandoc

  # syncthnig for acoustic people
  rsync

  dconf
  rustup
  figlet
  unzip
  hs
]
