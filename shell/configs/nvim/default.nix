{
  pkgs,
  colors,
  ...
}: let
  nvfetcher = builtins.mapAttrs (name: value:
    pkgs.vimUtils.buildVimPlugin {
      inherit name;
      inherit (value) src;
    }) (pkgs.callPackages ./_sources/generated.nix {});

  theme = with colors; ''

  '';

  lua = pkgs.writeText "init.lua" (theme + builtins.readFile ./init.lua);

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withPython3 = false;
    withRuby = false;
    withNodeJs = false;
    customRC = ''
      source ${./init.vim}
      :luafile ${lua}
    '';

    plugins =
      (builtins.attrValues nvfetcher)
      ++ (with pkgs.vimPlugins; [
        lualine-nvim
        nvim-web-devicons
        gitsigns-nvim
        vim-fugitive
        indent-blankline-nvim-lua
        nvim-autopairs
        neoformat
        comment-nvim
        nvim-colorizer-lua
        which-key-nvim
        undotree
        vim-speeddating
        luasnip
        vim-startuptime
        telescope-nvim
        harpoon
        alpha-nvim
        zen-mode-nvim
        sniprun
        vim-table-mode
        trouble-nvim
        nvim-cokeline
        fidget-nvim
        nvim-notify

        # Language support
        nvim-lspconfig
        nvim-cmp
        friendly-snippets
        cmp-cmdline
        cmp-nvim-lsp
        cmp-buffer
        cmp-path

        nvim-treesitter.withAllGrammars

        vimwiki
        cmp-vimwiki-tags
        mattn-calendar-vim

        nui-nvim
        plenary-nvim
      ]);
  };
in {
  basePackage = pkgs.wrapNeovimUnstable pkgs.neovim-unwrapped neovimConfig;
  # mostly LSP related packages
  pathAdd = with pkgs; [
    gopls
    go
    nil
    rust-analyzer
    alejandra
    vscode-langservers-extracted
    bash-language-server
    clang-tools
    zls
    gleam
    nodePackages.typescript-language-server
    nodePackages.prettier
    clang-tools
    shellcheck
    cargo
    nixd
    stylua

    # required for my goofy ahh plugin :3
    libsixel
  ];
}
