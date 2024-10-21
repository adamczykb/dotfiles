{
  config,
  lib,
  ...
}: {
  programs.thunderbird = {
    enable = true;
    settings = {"privacy.donottrackheader.enabled" = true;};
    profiles.personal = {
      isDefault = true;
      withExternalGnupg = true;

      settings = {
        "mail.identity.default.archive_enabled" = true;
        "mail.identity.default.archive_keep_folder_structure" = true;
        "mail.identity.default.compose_html" = false;
        "mail.identity.default.protectSubject" = true;
        "mail.identity.default.reply_on_top" = 1;
        "mail.identity.default.sig_on_reply" = false;

        "gfx.webrender.all" = true;
        "gfx.webrender.enabled" = true;

        "browser.display.use_system_colors" = true;
        "browser.theme.dark-toolbar-theme" = true;
      };
    };
  };
  # home.persistence."/state".directories = [
  #   ".cache/thunderbird"
  #   ".thunderbird"
  # ];
}
