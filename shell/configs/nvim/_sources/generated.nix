# This file was generated by nvfetcher, please do not modify it manually.
{ fetchgit, fetchurl, fetchFromGitHub, dockerTools }:
{
  incline = {
    pname = "incline";
    version = "16fc9c073e3ea4175b66ad94375df6d73fc114c0";
    src = fetchFromGitHub {
      owner = "b0o";
      repo = "incline.nvim";
      rev = "16fc9c073e3ea4175b66ad94375df6d73fc114c0";
      fetchSubmodules = false;
      sha256 = "sha256-5DoIvIdAZV7ZgmQO2XmbM3G+nNn4tAumsShoN3rDGrs=";
    };
    date = "2024-05-16";
  };
  neotree = {
    pname = "neotree";
    version = "206241e451c12f78969ff5ae53af45616ffc9b72";
    src = fetchFromGitHub {
      owner = "nvim-neo-tree";
      repo = "neo-tree.nvim";
      rev = "206241e451c12f78969ff5ae53af45616ffc9b72";
      fetchSubmodules = false;
      sha256 = "sha256-eNGuQEjAKsPuRDGaw95kCVOmP64ZDnUuFBppqtcrhZ4=";
    };
    date = "2024-06-11";
  };
  nvim-base-16 = {
    pname = "nvim-base-16";
    version = "6ac181b5733518040a33017dde654059cd771b7c";
    src = fetchFromGitHub {
      owner = "RRethy";
      repo = "nvim-base16";
      rev = "6ac181b5733518040a33017dde654059cd771b7c";
      fetchSubmodules = false;
      sha256 = "sha256-GRF/6AobXHamw8TZ3FjL7SI6ulcpwpcohsIuZeCSh2A=";
    };
    date = "2024-05-23";
  };
  org-bullets = {
    pname = "org-bullets";
    version = "7e76e04827ac3fb13fc645a6309ac14203c4ca6a";
    src = fetchFromGitHub {
      owner = "nvim-orgmode";
      repo = "org-bullets.nvim";
      rev = "7e76e04827ac3fb13fc645a6309ac14203c4ca6a";
      fetchSubmodules = false;
      sha256 = "sha256-bxiL88uUa0Zd/HL7RcC/XVhbkgdlFr6MmlQfkpxFybE=";
    };
    date = "2024-07-09";
  };
  recession = {
    pname = "recession";
    version = "e087ebeef81df25a12fcc4ec067ca73e2bb54c4a";
    src = fetchFromGitHub {
      owner = "stevearc";
      repo = "resession.nvim";
      rev = "e087ebeef81df25a12fcc4ec067ca73e2bb54c4a";
      fetchSubmodules = false;
      sha256 = "sha256-Id7rJwxvH81TnBKHAsPuP8nmu7SS6b5PiLoE2UzeRX0=";
    };
    date = "2024-07-01";
  };
  scope = {
    pname = "scope";
    version = "86a0f5b594b08b2ad65f470ffdee81654942b6ac";
    src = fetchFromGitHub {
      owner = "tiagovla";
      repo = "scope.nvim";
      rev = "86a0f5b594b08b2ad65f470ffdee81654942b6ac";
      fetchSubmodules = false;
      sha256 = "sha256-8Bd1DI6nuUxkTCx0wCfWKHdi6UXQNuDygj5UuSGypLs=";
    };
    date = "2024-03-31";
  };
  telescope-orgmode = {
    pname = "telescope-orgmode";
    version = "b1d0fab19fafeb7de0fd78b16d4c023021c01765";
    src = fetchFromGitHub {
      owner = "nvim-orgmode";
      repo = "telescope-orgmode.nvim";
      rev = "b1d0fab19fafeb7de0fd78b16d4c023021c01765";
      fetchSubmodules = false;
      sha256 = "sha256-46R9HO6kmGmWzBXAiL+SeR44uj0P716vwOfUTI8ec7E=";
    };
    date = "2024-07-07";
  };
}
