{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/1e8bc658fc985ef27ccd66d107d767b32bb7ef98";
  };
  outputs =
    { nixpkgs, ... }:
    let
      eachSupportedSystem = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      eachPkgs = f: eachSupportedSystem (system: f (nixpkgs.legacyPackages.${system}));
    in
    builtins.mapAttrs (_: eachPkgs) {
      formatter = pkgs: pkgs.nixfmt;
      packages = pkgs: rec {
        default = mugvim;
        mugvim = pkgs.callPackage ./package.nix { };
      };
      devShells =
        pkgs:
        pkgs.mkShell {
          packages = with pkgs; [
            packages.mugvim
            neovim
            tree-sitter
            zig
            nurl
          ];
        };
    };
}
