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
    in
    {
      packages = eachSystem (system: rec {
        default = mugvim;
        mugvim = pkgsFor.${system}.callPackage ./nix/mugvim.nix { };
      });
    };
}
