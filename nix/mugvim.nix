{
  stdenv,
  pkgs,
  makeWrapper,
}:
stdenv.mkDerivation rec {
  pname = "mugvim";
  version = "2.0.0-alpha1";

  sourceRoot = ".";
  src = ../.;

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
    chmod +x $out/bin/mugvim
  '';

  postFixup = ''
    wrapProgram "$out/bin/mugvim" \
        --set MUGVIM_BASE_DIR "$out"
  '';
}
