{
    description = "Personal icon font";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    outputs = inputs @ { self, nixpkgs, ... }:
        let
            # TODO: Add more systems

            system = "x86_64-linux";
            pkgs   = import nixpkgs { inherit system; };
            build  = pkgs.callPackage ./build/nix { source = ./.; };
        in
        {
            packages.${system} = build.pkgs;
        };
}
