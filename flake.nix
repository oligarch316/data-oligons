{
    description = "Personal icons";

    inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    outputs = { nixpkgs, ... }:
        let
            # TODO: Add more systems
            system = "x86_64-linux";
            source = ./.;

            load = pkgs: path: pkgs.callPackage path { inherit source; };
        in
        {
            packages.${system} =
                let
                    pkgs  = import nixpkgs { inherit system; };
                    load' = load pkgs;
                in
                {
                    default = load' ./build/nix;
                    font    = load' ./build/nix/font.nix;
                    vscode  = load' ./build/nix/vscode.nix;
                };

            overlays.default = _: prev: { oligons = load prev.pkgs ./build/nix; };
        };
}
