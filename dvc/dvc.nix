{ pypkgs, pypi2nix, reflink }:
pypkgs.buildPythonPackage rec {
  pname = "dvc";
  version = "0.17.0";
  format = "wheel";
  src = pypkgs.fetchPypi {
    inherit pname version;
    format="wheel";
    sha256 = "1297fzdxcqypfvbz4wwhmnysc8qippsak61hnrf35cqx4qz2y2zj";
  };
  doCheck=false;
  catchConflicts=false;
  buildInputs = [
    pypi2nix."configparser"
    pypkgs.pyyaml
    pypkgs.networkx
    pypkgs.schema
    reflink
    pypkgs.pyasn1
    pypkgs.colorama
    pypkgs.future
    pypi2nix."ply"
    pypi2nix."ntfsutils"
    pypi2nix."nanotime"
    pypi2nix."jsonpath-rw"
    pypkgs.requests
    pypkgs.configobj
    pypi2nix."zc.lockfile"
    pypi2nix."GitPython"
  ];
}
