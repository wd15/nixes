let
  nixpkgs = import ./nixpkgs_version.nix;
  pypkgs = nixpkgs.python27Packages;
  pyamgx = import ./pyamgx.nix { inherit nixpkgs; inherit pypkgs; };
  amgx = import ./amgx.nix { inherit nixpkgs; };
  pysparse = import ../fipy-py2/pysparse.nix { inherit nixpkgs; };
in
  pypkgs.buildPythonPackage rec {
    pname = "fipy";
    version = "3.1.3";
    src=./fipy;   
    prePatch = ''
      sed -i 's/version = getVersion()/version="${version}"/' setup.py
    ''; 
    doCheck=false;
    buildInputs = [
      pypkgs.numpy
      pypkgs.scipy
      pyamgx
      pysparse
    ];
    AMGX_DIR = "${amgx.out}";
    shellHook = ''
      export LD_LIBRARY_PATH=${nixpkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
      export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libcuda.so /usr/lib/nvidia-384/libnvidia-fatbinaryloader.so.384.111";
    '';
  }
