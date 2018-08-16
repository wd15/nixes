{ pypkgs }:
pypkgs.buildPythonPackage rec {
  pname = "reflink";
  version = "0.2.0";
  src = pypkgs.fetchPypi {
    inherit pname version;
    sha256 = "16bw4wmnaphsks7956ss1lj0gmjmkl8mddkbmb1d8hyy3mqxb9m6";
  };
  doCheck=false;
  buildInputs = [
    pypkgs.cffi
  ];
}
