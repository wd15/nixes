{ nixpkgs ? import <nixpkgs> {} }:
let
  amgx = import ./amgx.nix { inherit nixpkgs; };
in
  nixpkgs.python27Packages.buildPythonPackage rec {
    pname = "pyamgx";
    version = "";
    src = nixpkgs.fetchFromGitHub {
      owner = "shwina";
      repo = pname;
      rev = "fac3c841e1527942da64c7d1805d1ffe94f58766";
      sha256 = "1752yhhq82980qhn5i8mngjlybkgvp96qlgnv6y5cdn8921m8h2s";
    };
    doCheck=true;
    buildInputs = [
      nixpkgs.python27Packages.scipy
      nixpkgs.python27Packages.numpy
      amgx
      nixpkgs.python27Packages.cython
    ];
    AMGX_DIR = "${amgx.out}";
  }

