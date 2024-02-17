{ pkgs, source, ... }:

let
    inherit ( pkgs ) callPackage;

    oligonsPkg = callPackage ./package.nix { inherit source; };
in

{
    # TODO: Add devShell?
    pkgs = { default = oligonsPkg; oligons = oligonsPkg; };
}
