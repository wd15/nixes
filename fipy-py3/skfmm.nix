{ nixpkgs }:
nixpkgs.python36Packages.buildPythonPackage rec {
  version = "0.0.9";
  pname = "scikit-fmm";
  src = nixpkgs.python36Packages.fetchPypi {
    inherit pname version;
    sha256 = "192f4rzh32bz3gs5cqybxrg0jqjyp751kxfdx27paf81v7cwg2ky";
  };
  doCheck=false;
  buildInputs = [
    nixpkgs.python36Packages.numpy
  ];
}
