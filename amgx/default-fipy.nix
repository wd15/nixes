let
  nixpkgs = import ../nixpkgs_version.nix;
  pypkgs = nixpkgs.python27Packages;
  pyamgx = import ../pyamgx.nix { inherit nixpkgs; inherit pypkgs; };
  amgx = import ../amgx.nix { inherit nixpkgs; };
  pysparse = import ../../fipy-py2/pysparse.nix { inherit nixpkgs; };
  gmsh = import ../../fipy-py2/gmsh.nix { inherit nixpkgs; };
  skfmm = import ../../fipy-py2/skfmm.nix { inherit nixpkgs; };
in
  pypkgs.buildPythonPackage rec {
    pname = "fipy1";
    version = "3.1.3";
    env = nixpkgs.buildEnv { name=pname; paths=buildInputs; };
    src=./.;
    prePatch = ''
      sed -i 's/version = getVersion()/version="${version}"/' setup.py
    ''; 
    doCheck=false;
    catchConflicts=false;
    buildInputs = [
      pypkgs.numpy
      pypkgs.scipy
      pyamgx
      pysparse
      gmsh
      skfmm
    ];
    AMGX_DIR = "${amgx.out}";
    postShellHook = ''
      export LD_LIBRARY_PATH=${nixpkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
      export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libcuda.so /usr/lib/nvidia-384/libnvidia-fatbinaryloader.so.384.130";
    ''; 
 }
