{
  stdenv,
  pkgs,
}:
stdenv.mkDerivation rec {
  pname = "mugvim";
  version = "0.0.0";

  sourceRoot = ".";
  src = ../.;

  application = pkgs.writeTextFile {
    executable = true;
    name = pname;
    text = ''NVIM_APPNAME=${pname} ${pkgs.neovim}/bin/nvim -u $out/init.lua "$@"'';
  };

  installPhase = ''
    cp -r $src $out
    chmod +x $out/bin/mugvim
  '';
}
