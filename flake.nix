{
  inputs = {
    nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/b51242d7d43689db2f3be91bd05d5b24fbb469c4.tar.gz";
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
