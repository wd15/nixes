{ nixpkgs ? import ./nixpkgs_version.nix }:
let
  python36Packages = nixpkgs.python36Packages;
  gmsh = import ./gmsh.nix { inherit nixpkgs; };
  skfmm = import ./skfmm.nix { inherit nixpkgs; };
  fipy = import ./fipy.nix { inherit nixpkgs; };
  nbval = import ./nbval.nix { inherit nixpkgs; };
  pytest-cov = import ./pytest-cov.nix { inherit nixpkgs; };
in
  nixpkgs.stdenv.mkDerivation rec {
    name = "fipy-py3-env";
    env = nixpkgs.buildEnv { name=name; paths=buildInputs; };
    buildInputs = [
      python36Packages.jupyter
      python36Packages.matplotlib
      python36Packages.numpy
      python36Packages.scipy
      python36Packages.pytest
      pytest-cov
      fipy
      gmsh
      skfmm
      nbval
    ];
  }
