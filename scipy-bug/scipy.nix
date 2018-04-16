{ pkgs ? import <nixpkgs> {}
}:
let
  pypi2nix = import ./requirements.nix { inherit pkgs; };
  python36Packages = pkgs.python36Packages;
in
  pypi2nix.mkDerivation {
  name = "scipy-1.0.1";
  src = pkgs.fetchurl {
    url = "https://pypi.python.org/packages/bd/f4/3882758754dc083fea6ea66a6e8ceef55e7df173d06a12a074612958800f/scipy-1.0.1.tar.gz";
    sha256 = "8739c67842ed9a1c34c62d6cca6301d0ade40d50ef14ba292bd331f0d6c940ba";
  };
  doCheck=false;
  buildInputs = [
    pkgs.gfortran
    pkgs.blas
    pypi2nix.packages.numpy
  ];

}
