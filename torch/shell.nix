let
  inherit (import <nixpkgs> {}) fetchFromGitHub;
  nixpkgs_download = fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "5e46d5a7b59d69e7b86239195f58d26277ae0370";
    sha256 = "0xynhyafvj8mazmagpnxp0k6l5wjfcg8j0syxvs4v87hf0g6n917";
 };
  pkgs = import nixpkgs_download {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };
  pythonPackages = pkgs.python3Packages;
  pytorchWithCuda9 = pythonPackages.pytorchWithCuda.override {
    cudatoolkit=pkgs.cudatoolkit_9_0;
  };
in
  pkgs.stdenv.mkDerivation rec {
    pname = "pytorch-play1";
    version = "0.1";
    nativeBuildInputs = with pythonPackages; [
      scipy
      numpy
      matplotlib
      jupyter
      tkinter
      toolz
      pylint
      flake8
      black
      ipywidgets
      pytorchWithCuda9
      pkgs.cudatoolkit_9_0
    ];
    src = null;
    ##src=builtins.filterSource (path: type: type != "directory" || baseNameOf path != ".git") ./.; 
    shellHook = ''
      jupyter nbextension install --py widgetsnbextension --user > /dev/null 2>&1
      jupyter nbextension enable widgetsnbextension --user --py  > /dev/null 2>&1
      pip install jupyter_contrib_nbextensions --user > /dev/null 2>&1
      jupyter contrib nbextension install --user > /dev/null 2>&1
      jupyter nbextension enable spellchecker/main > /dev/null 2>&1

      export OMPI_MCA_plm_rsh_agent=/usr/bin/ssh

      SOURCE_DATE_EPOCH=$(date +%s)
      export PYTHONUSERBASE=$PWD/.local
      export USER_SITE=`python -c "import site; print(site.USER_SITE)"`
      export PYTHONPATH=$PYTHONPATH:$USER_SITE
      export PATH=$PATH:$PYTHONUSERBASE/bin

      export CUDAPATH="/usr/lib/x86_64-linux-gnu"
      export LD_PRELOAD=$CUDAPATH/libcuda.so.1:$CUDAPATH/libnvidia-fatbinaryloader.so.390.116:$CUDAPATH/libnvidia-ptxjitcompiler.so.1:$CUDAPATH/libnvidia-ml.so.1
      # To install extra packages use
      #
      # $ pip install --user <package>

    '';
  }
