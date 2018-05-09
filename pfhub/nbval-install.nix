let
  nixpkgs = import ./nixpkgs_version.nix;
  pkgs = nixpkgs.pkgs;
  nbval = import ./nbval.nix { inherit pkgs; };
  python36Packages = nixpkgs.python36Packages;
in
  nixpkgs.stdenv.mkDerivation rec {
    name = "env1";
    env = nixpkgs.buildEnv { name=name; paths=buildInputs; };
    buildInputs = [
      nbval
      python36Packages.jupyter
      python36Packages.matplotlib
      python36Packages.pytest
    ];
  }
