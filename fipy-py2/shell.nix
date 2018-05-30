{ nixpkgs ? import ./nixpkgs_version.nix }:
let
  gmsh = import ./gmsh.nix { inherit nixpkgs; };
  skfmm = import ./skfmm.nix { inherit nixpkgs; };
  pysparse = import ./pysparse.nix { inherit nixpkgs; };
  fipy = import ./fipy.nix { inherit nixpkgs; };
in
  nixpkgs.stdenv.mkDerivation rec {
    name = "fipy-py2-env";
    env = nixpkgs.buildEnv { name=name; paths=buildInputs; };
    buildInputs = [
      nixpkgs.python27Packages.numpy
      nixpkgs.python27Packages.scipy
      fipy
      gmsh
      skfmm
      pysparse
      nixpkgs.python27Packages.matplotlib
      nixpkgs.python27Packages.tkinter
    ];
  }
