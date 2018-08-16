let
  nixpkgs = import ./nixpkgs_version.nix;
  pypkgs = nixpkgs.python36Packages;
  reflink = import ./reflink.nix { inherit pypkgs; };
  dvc = import ./dvc.nix { inherit pypkgs pypi2nix reflink; };
  pkgs = nixpkgs.pkgs;
  pypi2nix = (import ./requirements.nix { inherit pkgs; }).packages;
in
  nixpkgs.stdenv.mkDerivation {
    name = "env";
    buildInputs = [
      dvc
    ] ++ dvc.buildInputs;
    src = null;
  }
