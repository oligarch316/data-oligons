{ lib, pkgs, source, ... }:

let
    inherit ( pkgs        ) callPackage;
    inherit ( pkgs.stdenv ) mkDerivation;

    fontPkg   = callPackage ./font.nix { inherit source; };
    vscodePkg = callPackage ./vscode.nix { inherit source; };
in

mkDerivation {
    pname        = "oligons";
    version      = "0.1.0";
    outputs      = [ "out" "font" "vscode" ];
    phases       = [ "installPhase" ];
    installPhase = ''
        mkdir -p $out $font $vscode

        ln -s ${fontPkg}   $out
        ln -s ${fontPkg}   $font
        ln -s ${vscodePkg} $vscode
    '';

    meta = {
        description = "Personal icons";
        homepage    = "https://github.com/oligarch316/data-oligons";
        platforms   = lib.platforms.linux;
    };
}
