let
  inherit (import <nixpkgs> {}) fetchFromGitHub;
  nixpkgs = import ../fipy-py2/nixpkgs_version.nix;
  fipy = import ../fipy-py2/fipy.nix { inherit nixpkgs; };
  skfmm = import ../fipy-py2/skfmm.nix { inherit nixpkgs; };
  gmsh = import ../fipy-py2/gmsh.nix { inherit nixpkgs; };
  amgx = import ./amgx.nix { inherit nixpkgs; };
in
  nixpkgs.stdenv.mkDerivation rec {
    name = "pyamgx-env";
    env = nixpkgs.buildEnv { name=name; paths=buildInputs; };
    buildInputs = [
      nixpkgs.python27Packages.numpy
      nixpkgs.python27Packages.scipy
      nixpkgs.python27Packages.jupyter
      nixpkgs.python27Packages.matplotlib
      fipy
      skfmm
      amgx
    ];
  }
