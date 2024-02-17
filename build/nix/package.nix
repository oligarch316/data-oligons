{ pkgs, source, ... }:

let
    inherit ( pkgs        ) buildNpmPackage fetchFromGitHub;
    inherit ( pkgs.stdenv ) mkDerivation;

    drvFantasticon = buildNpmPackage rec {
        pname       = "fantasticon";
        version     = "2.0.0";
        npmDepsHash = "sha256-EYjZP+WCxJ3CsX8ZNz12F6MtzToOfD5rkXIeQgA5q8c=";

        src = fetchFromGitHub {
            owner  = "tancredi";
            repo   = pname;
            rev    = "v${version}";
            sha256 = "sha256-4DwcW45qyI8B5FAdSv4NbYY2Gx+u1n7M2ku4T8HbAv0=";
        };
    };

    drvOligons = mkDerivation {
        pname       = "oligons";
        version     = "0.1.0";
        src         = source;
        buildInputs = [ drvFantasticon ];
        outputs     = [ "out" "dev" "index" ];

        phases       = [ "unpackPhase" "buildPhase" "installPhase" ];
        buildPhase   = "make font";
        installPhase = ''
            mkdir -p $dev $index $out/share/fonts/truetype

            install build/font/*      $dev
            install build/font/*.json $index
            install build/font/*.ttf  $out/share/fonts/truetype
        '';

        meta = {
            description = "Personal icons";
            homepage    = "https://github.com/oligarch316/data-oligons";
        };
    };
in

drvOligons
