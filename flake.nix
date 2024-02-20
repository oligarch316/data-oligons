{
    description = "Personal icons";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    outputs = { self, nixpkgs, ... }:
        let
            # TODO: Add more systems
            system = "x86_64-linux";
            pkgs   = import nixpkgs { inherit system; };
            build  = pkgs.callPackage ./build/nix { source = ./.; };
        in
        {
            packages.${system} = build.packages;
            overlays.default   = _: prev: self.packages.${prev.system};
        };
}
