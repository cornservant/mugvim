{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, ... }:
        rec {
          formatter = pkgs.nixfmt-rfc-style;

          packages = rec {
            default = mugvim;
            mugvim = pkgs.callPackage ./package.nix { };
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
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
