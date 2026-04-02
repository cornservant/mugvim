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
        let
          mugvim = pkgs.callPackage ./package.nix { };
        in
        {
          formatter = pkgs.nixfmt-rfc-style;

          packages = {
            inherit mugvim;
            default = mugvim;
          };

          devShells.default = pkgs.mkShell {
            packages = with pkgs; [
              mugvim
              neovim
              tree-sitter
              zig
            ];
          };
        };
    };
}
