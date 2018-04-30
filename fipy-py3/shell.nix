{ nixpkgs ? import ./nixpkgs_version.nix }:
let
  python36Packages = nixpkgs.python36Packages;
  gmsh = import ./gmsh.nix { inherit nixpkgs; };
  skfmm = import ./skfmm.nix { inherit nixpkgs; };
  fipy = import ./fipy.nix { inherit nixpkgs; };
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
