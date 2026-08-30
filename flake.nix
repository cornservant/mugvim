{
  inputs = {
    nixpkgs.url = "https://github.com/NixOS/nixpkgs/archive/f4f698677b11021a8f84f452e23ae9ef2427bec3.tar.gz";
  };
  outputs =
    { nixpkgs, ... }:
    let
      eachSupportedSystem = nixpkgs.lib.genAttrs nixpkgs.lib.systems.flakeExposed;
      eachPkgs = f: eachSupportedSystem (system: f (nixpkgs.legacyPackages.${system}));
    in
    {
      formatter = eachPkgs (pkgs: pkgs.nixfmt);
      packages = eachPkgs (pkgs: rec {
        default = mugvim;
        mugvim = pkgs.callPackage ./package.nix { };
      });
      devShells = eachPkgs (
        pkgs:
        pkgs.mkShell {
          packages = with pkgs; [
            packages.mugvim
            neovim
            tree-sitter
            zig
            nurl
          ];
        }
      );
    };
}
