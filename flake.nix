{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    blink = {
      url = "github:saghen/blink.cmp/v1.10.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, ... }:
        let
          blink-fuzzy-lib = inputs.blink.packages.${pkgs.stdenv.hostPlatform.system}.blink-fuzzy-lib;
        in
        rec {
          formatter = pkgs.nixfmt-rfc-style;

          packages = rec {
            default = mugvim;
            mugvim = pkgs.callPackage ./package.nix { inherit blink-fuzzy-lib; };
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              blink-fuzzy-lib
              packages.mugvim
              neovim
              tree-sitter
              zig
              nurl
            ];
          };
        };
    };
}
