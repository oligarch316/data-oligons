{ pkgs, source, ... }:

let
    inherit ( pkgs ) callPackage;

    fontPkg   = pkgs.callPackage ./font.nix   { inherit source; };
    # TODO: vscodePkg = pkgs.callPackage ./vscode.nix { inherit source; };
in

{
    packages.default = fontPkg;
    packages.font    = fontPkg;
    # TODO: packages.vscode  = vscodePkg;
}
