{
  inputs = {
    nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/f4f698677b11021a8f84f452e23ae9ef2427bec3.tar.gz";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };
  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      perSystem =
        { pkgs, ... }:
        rec {
          formatter = pkgs.nixfmt;

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
