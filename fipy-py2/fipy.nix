{ nixpkgs }:
nixpkgs.python27Packages.buildPythonPackage rec {
  pname = "fipy";
  version = "3.1.3.dev256+g43bbbd65";
  src = nixpkgs.fetchFromGitHub {
    owner = "usnistgov";
    repo = pname;
    rev = "43bbbd65ea1867fe73b0a58e00834aec5a616dc4";
    sha256 = "1lm2kh8axmqxfaqgs4zma749hx7g7bkkwzgkflrnr8bkr3dqrm3s";
  };
  prePatch = ''
    sed -i 's/version = getVersion()/version="${version}"/' setup.py
  '';
  doCheck=false;
  buildInputs = [
    nixpkgs.python27Packages.numpy
    nixpkgs.python27Packages.scipy
  ];
  meta = {
    homepage = "https://www.ctcms.nist.gov/fipy/";
    description = "A Finite Volume PDE Solver Using Python";
    version = "3.1.3.dev256+g43bbbd65";
    license = nixpkgs.stdenv.lib.licenses.free;
  };
}
