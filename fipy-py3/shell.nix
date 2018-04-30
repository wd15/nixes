{ nixpkgs ? import ./nixpkgs_version.nix }:
let
  python36Packages = nixpkgs.python36Packages;
  gmsh = import ./gmsh.nix { inherit nixpkgs; };
  skfmm = import ./skfmm.nix { inherit nixpkgs; };
  fipy = nixpkgs.python36Packages.buildPythonPackage rec {
    pname = "fipy";
    version = "3.1.3.dev256+g43bbbd65";
    src = nixpkgs.fetchFromGitHub {
      owner = "usnistgov";
      repo = pname;
      rev = "43bbbd65ea1867fe73b0a58e00834aec5a616dc4";
      sha256 = "1lm2kh8axmqxfaqgs4zma749hx7g7bkkwzgkflrnr8bkr3dqrm3s";
    };
    prePatch = ''
      2to3 --write . &> /dev/null;
      2to3 --write --doctests_only . &> /dev/null;
      sed -i 's/version = getVersion()/version="${version}"/' setup.py
    '';
    doCheck=false;
    buildInputs = [
      nixpkgs.pkgs.python27
      python36Packages.numpy
      python36Packages.scipy
    ];
    meta = {
      homepage = "https://www.ctcms.nist.gov/fipy/";
      description = "A Finite Volume PDE Solver Using Python";
      version = "3.1";
      license = nixpkgs.stdenv.lib.licenses.free;
    };
  };
in
  nixpkgs.stdenv.mkDerivation rec {
    name = "fipy-py3-env";
    env = nixpkgs.buildEnv { name=name; paths=buildInputs; };
    buildInputs = [
      python36Packages.numpy
      python36Packages.scipy
      fipy
      gmsh
      skfmm
    ];
  }
