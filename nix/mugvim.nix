{
  stdenv,
  lib,
  pkgs,
  makeWrapper,
  tree-sitter,      # for treesitter
  zig,              # for treesitter
  imagemagick,      # for snacks.image
  typst,            # for snacks.image
  tectonic,         # for snacks.image
  ghostscript,      # for snacks.image
  mermaid-cli,      # for snacks.image
}:
stdenv.mkDerivation rec {
  pname = "mvim";
  version = "2.1.0";

  sourceRoot = ".";
  src = builtins.path {
    path = ../.;
    name = "source";
  };

  application = pkgs.writeTextFile {
    executable = true;
    name = pname;
    text = ''NVIM_APPNAME=${pname} ${pkgs.neovim}/bin/nvim -u $out/init.lua "$@"'';
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase = ''
    cp -r $src $out
    chmod +x $out/bin/mvim
  '';

  postFixup = ''
    wrapProgram "$out/bin/mvim" \
        --set MUGVIM_BASE_DIR "$out" \
        --prefix PATH : "${
            lib.makeBinPath [
                tree-sitter      # for treesitter
                zig              # for treesitter
                imagemagick      # for snacks.image
                typst            # for snacks.image
                tectonic         # for snacks.image
                ghostscript      # for snacks.image
                mermaid-cli      # for snacks.image
            ]
        }"
  '';
}
