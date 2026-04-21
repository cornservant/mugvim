{
  stdenv,
  lib,
  makeWrapper,
  tree-sitter,
  zig,
  imagemagick,
  typst,
  neovim,
  blink-fuzzy-lib,
  fetchFromGitHub,
  fetchgit,
  writeTextFile,
}:
let
  version = lib.trimWith { end = true; } (builtins.readFile ./VERSION);
  base-deps = [
    neovim
  ];
  tree-sitter-deps = [
    tree-sitter
    zig
  ];
  snacks-image-deps = [
    imagemagick
    typst
  ];
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
      export PATH="${lib.makeBinPath (base-deps ++ tree-sitter-deps ++ snacks-image-deps)}:$PATH"
      ${lib.getExe neovim} -u "$MUGVIM_BASE_DIR/init.lua" "$@"
    '';
  };

  nativeBuildInputs = [
    makeWrapper
  ];

  installPhase =
    let
      installPlugins = lib.join "" (
        lib.mapAttrsToList (name: plugin: ''
          cp -r ${plugin} $out/pack/default/start/${name}
          find $out/pack/default/start/${name} -type d -exec chmod 755 {} +
        '') plugins
      );

      installBlinkFuzzyLib =
        if lib.hasAttr "blink.cmp" plugins then
          ''
            mkdir -p $out/pack/default/start/blink.cmp/target/release
            install -m 555 -D ${blink-fuzzy-lib}/lib/libblink_cmp_fuzzy.so \
              $out/pack/default/start/blink.cmp/target/release/libblink_cmp_fuzzy.so
          ''
        else
          "";
    in
    ''
      install -m 444 -D $src/init.lua   $out/init.lua
      install -m 444 -D $src/VERSION    $out/VERSION
      install -m 555 -D ${application}  $out/bin/mvim
      cp -r             $src/runtime    $out/runtime
      find                              $out/runtime -type d -exec chmod 755 {} +
      mkdir -p                          $out/pack/default/start
      ${installPlugins}
      ${installBlinkFuzzyLib}
      install -m 444 -D $src/resources/mugvim.desktop \
        $out/share/applications/mugvim.desktop
      install -m 444 -D $src/resources/mugvim.svg \
        $out/share/icons/hicolor/scalable/apps/mugvim.svg
    '';
}
