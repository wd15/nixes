with import <nixpkgs> { };

( let my_nbval = python36.pkgs.buildPythonPackage rec {
  pname = "nbval";
  version = "0.9.0";
  src = python36.pkgs.fetchPypi {
    inherit pname version;
    sha256 = "dec2a26bb32a29f92a577554b7142f960b8a91bca8cfaf23f4238718197bf7f3";
  };
  doCheck = false;
  buildInputs = [
    python36Packages.ipython
    python36Packages.jupyter_client
    python36Packages.tornado
    python36Packages.pytest
  ];
};
in python36.withPackages (ps: [ps.pytest my_nbval])
).env
