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

  lua = pkgs.writeText "init.lua" (builtins.readFile ./init.lua);

  neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
    withPython3 = true;
    withRuby = false;
    withNodeJs = true;
    vimAlias = true;
    vimdiffAlias = true;

    customRC = ''
      source ${./init.vim}
      :luafile ${lua}
    '';

    plugins =
      (builtins.attrValues nvfetcher)
      ++ (with pkgs.vimPlugins; [
        kanagawa-nvim
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
        markdown-preview-nvim
        # Language support
        nvim-lspconfig
        nvim-cmp
        friendly-snippets
        cmp-cmdline
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        nvim-jdtls
        nvim-treesitter.withAllGrammars
        haskell-tools-nvim
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
    pyright
    gleam
    haskellPackages.hoogle
    jdt-language-server
    haskell-language-server
    nodePackages.typescript-language-server
    nodePackages.prettier
    clang-tools
    shellcheck
    cargo
    nixd
    stylua
    haskellPackages.implicit-hie
    # required for my goofy ahh plugin :3
    libsixel
  ];
}
