{
  stdenv,
  lib,
  fetchgit,
  neovim,
  vimPlugins,
  vimUtils,
  tree-sitter,
  ripgrep,
  git,
  writeTextFile,
  imagemagick,
  include_imagemagick ? true,
  ghostscript,
  include_ghostscript ? false,
  tectonic,
  include_tectonic ? false,
  mermaid-cli,
  include_mermaid-cli ? false,
}:
let
  version = lib.trimWith { end = true; } (builtins.readFile ./VERSION);
  mugvim-lib = vimUtils.buildVimPlugin {
    pname = "mugvim-lib";
    inherit version;
    src = ./runtime;
  };
  bufferline-editor-nvim = vimUtils.buildVimPlugin rec {
    pname = "bufferline-editor-nvim";
    version = "0.2.1";
    src = fetchgit {
      url = "https://git.loporrit.de/long/bufferline-editor.nvim";
      rev = version;
      hash = "sha256-rrurGpDyoHBgKKJxUOxzPnmDpRqYFMCXKsoIk1UsrHg=";
    };
    dependencies = with vimPlugins; [
      bufferline-nvim
      nvim-web-devicons
    ];
  };
  neovim_with_plugins = neovim.override {
    configure = {
      customRC = ''
        lua <<EOF
            require("mugvim"):init("${version}")
        EOF
      '';
      packages.mugvim = {
        start = with vimPlugins; [
          editorconfig-nvim
          blink-cmp
          bufferline-nvim
          bufferline-editor-nvim
          cloak-nvim
          comment-nvim
          gitsigns-nvim
          kanagawa-nvim
          lsp_lines-nvim
          nvim-lspconfig
          lualine-nvim
          luasnip
          mini-jump
          mini-move
          multicursor-nvim
          neogit
          nvim-cmp
          nvim-treesitter
          nvim-treesitter-context
          nvim-web-devicons
          obsidian-nvim
          oil-nvim
          plenary-nvim
          rose-pine
          vim-surround
          vim-repeat
          vim-just
          vim-peekaboo
          outline-nvim
          snacks-nvim
          todo-comments-nvim
          trouble-nvim
          tokyonight-nvim
          undotree
          vim-table-mode
          which-key-nvim
          fff-nvim
          mugvim-lib
        ];
      };
    };
  };
  deps = [
    tree-sitter
    ripgrep
    git
  ]
  ++ (if include_imagemagick then [ imagemagick ] else [ ])
  ++ (if include_ghostscript then [ ghostscript ] else [ ])
  ++ (if include_tectonic then [ tectonic ] else [ ])
  ++ (if include_mermaid-cli then [ mermaid-cli ] else [ ]);
in
stdenv.mkDerivation rec {
  pname = "mvim";
  inherit version;
  NVIM_APPNAME = "mugvim";

  sourceRoot = ".";
  src = builtins.path {
    path = ./.;
    name = "source";
  };

  application = writeTextFile {
    executable = true;
    name = pname;
    text = ''
      #!/usr/bin/env sh
      export NVIM_APPNAME=${NVIM_APPNAME}
      export PATH="${lib.makeBinPath deps}:$PATH"
      ${lib.getExe neovim_with_plugins} "$@"
    '';
  };

  installPhase = ''
    install -m 555 -D ${application}  $out/bin/mvim
    install -m 444 -D $src/resources/mugvim.desktop \
      $out/share/applications/mugvim.desktop
    install -m 444 -D $src/resources/mugvim.svg \
      $out/share/icons/hicolor/scalable/apps/mugvim.svg
  '';

  meta = {
    description = "Mug's neovim distribution";
    license = lib.licenses.asl20;
    mainProgram = pname;
  };
}
