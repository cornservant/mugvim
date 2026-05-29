{
  stdenv,
  lib,
  neovim,
  vimPlugins,
  tree-sitter,
  ripgrep,
  fetchFromGitHub,
  fetchgit,
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
  neovim_with_plugins = neovim.override {
    configure = {
      packages.testvim = {
        start = with vimPlugins; [
          editorconfig-nvim
          blink-cmp
          bufferline-nvim
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
        ];
      };
    };
  };
  deps = [
    tree-sitter
    ripgrep
  ]
  ++ (if include_imagemagick then [ imagemagick ] else [ ])
  ++ (if include_ghostscript then [ ghostscript ] else [ ])
  ++ (if include_tectonic then [ tectonic ] else [ ])
  ++ (if include_mermaid-cli then [ mermaid-cli ] else [ ]);
  plugins = lib.mapAttrs (
    name: spec:
    if !(lib.hasAttr "type" spec) then
      abort "plugin '${name}' does not specify a 'type' attribute'"
    else if spec.type == "github" then
      fetchFromGitHub {
        inherit (spec)
          owner
          repo
          rev
          hash
          ;
      }
    else if spec.type == "git" then
      fetchgit {
        inherit name;
        inherit (spec) url rev hash;
      }
    else
      abort "unknown plugin type ${spec.type}"
  ) (import ./plugins.nix);
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
      export MUGVIM_BASE_DIR=$(realpath "$(dirname "$(realpath "$0")")/..")
      export PATH="${lib.makeBinPath deps}:$PATH"
      ${lib.getExe neovim_with_plugins} -u "$MUGVIM_BASE_DIR/init.lua" "$@"
    '';
  };

  installPhase = ''
    install -m 444 -D $src/init.lua   $out/init.lua
    install -m 444 -D $src/VERSION    $out/VERSION
    install -m 555 -D ${application}  $out/bin/mvim
    cp -r             $src/runtime    $out/runtime
    find                              $out/runtime -type d -exec chmod 755 {} +
    mkdir -p                          $out/pack/default/start
    install -m 444 -D $src/resources/mugvim.desktop \
      $out/share/applications/mugvim.desktop
    install -m 444 -D $src/resources/mugvim.svg \
      $out/share/icons/hicolor/scalable/apps/mugvim.svg
  '';
}
