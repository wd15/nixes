let
  nixpkgs = import ./nixpkgs_version.nix;
  pyamgx = import ./pyamgx.nix { inherit nixpkgs; };
  amgx = import ./amgx.nix { inherit nixpkgs; };
in
  nixpkgs.stdenv.mkDerivation rec {
    name = "pyamgx-py27-env";
    env = nixpkgs.buildEnv { name=name; paths=buildInputs; };
    buildInputs = [
      pyamgx
      nixpkgs.python27Packages.numpy
      nixpkgs.python27Packages.scipy
    ];
    AMGX_DIR = "${amgx.out}";
    
    shellHook = ''
      export LD_LIBRARY_PATH=${nixpkgs.stdenv.cc.cc.lib}/lib:$LD_LIBRARY_PATH
      export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libcuda.so /usr/lib/nvidia-384/libnvidia-fatbinaryloader.so.384.111";
    '';
  }
