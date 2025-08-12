{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    systems.url = "github:nix-systems/default-linux";
  };
  outputs =
    inputs:
    let
      eachSystem = inputs.nixpkgs.lib.genAttrs (import inputs.systems);
      pkgsFor = eachSystem (system: inputs.nixpkgs.legacyPackages.${system});
      package =
        {
          stdenv,
          lib,
          pkgs,
          makeWrapper,
          tree-sitter,
          zig,
          imagemagick,
          typst,
          tectonic,
          ghostscript,
          mermaid-cli,
          gnumake,
          rustup,
        }:
        let
          version = pkgs.lib.trimWith { end = true; } (builtins.readFile ./VERSION);
          fff-deps = [
            gnumake
            rustup
          ];
          tree-sitter-deps = [
            tree-sitter
            zig
          ];
          snacks-image-deps = [
            imagemagick
            typst
            tectonic
            ghostscript
            mermaid-cli
          ];
        in
        stdenv.mkDerivation rec {
          pname = "mvim";
          inherit version;

          sourceRoot = ".";
          src = builtins.path {
            path = ./.;
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
                --prefix PATH : "${lib.makeBinPath (tree-sitter-deps ++ snacks-image-deps ++ fff-deps)}"
          '';
        };
    in
    {
      packages = eachSystem (system: rec {
        default = mugvim;
        mugvim = pkgsFor.${system}.callPackage package { };
      });
    };
}
