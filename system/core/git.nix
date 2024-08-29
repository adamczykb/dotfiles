{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    config = {
      user = {
        email = "contact@bartekadamczyk.eu";
        name = "adamczykb";
        # signingKey = "056CFD15A9F99B0E";
      };
      init = {defaultBranch = "main";};
      branch.autosetupmerge = "true";
      push.default = "current";
      merge.stat = "true";
      core.whitespace = "fix,-indent-with-non-tab,trailing-space,cr-at-eol";
      repack.usedeltabaseoffset = "true";
      pull.ff = "only";
      rebase = {
        autoSquash = true;
        autoStash = true;
      };
      rerere = {
        autoupdate = true;
        enabled = true;
      };
    };
  };
}
