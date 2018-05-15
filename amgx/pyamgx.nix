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
      rev = "df32133e38211c4351d33e8c9f1f16f029cf7eb3";
      sha256 = "0i996ymd6bws4k18clgwwmwy99d662gmmhc2qbn0vf4nr9659vf4";
    };
    doCheck=false;
    buildInputs = [
      nixpkgs.python27Packages.scipy
      nixpkgs.python27Packages.numpy
      amgx
    ];
    AMGX_DIR = "/blah";
    # shellHook = ''
    #   export AMGX_DIR = "/blah"
    # '';
  }
