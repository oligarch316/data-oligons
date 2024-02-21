{ pkgs, ... }:

# TODO:
# File Icon Theme:    https://code.visualstudio.com/api/extension-guides/file-icon-theme
# Product Icon Theme: https://code.visualstudio.com/api/extension-guides/product-icon-theme

let
    inherit ( pkgs.stdenv ) mkDerivation;
in

mkDerivation {
    pname        = "oligons-vscode";
    version      = "0.1.0";
    phases       = [ "installPhase" ];
    installPhase = ''
        mkdir -p $out
        echo "TODO: vscode extensions" > $out/TODO.txt
    '';
}
