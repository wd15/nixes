#
# $ nix-shell --pure --arg withBoost false --argstr tag 20.09
#

{
  tag ? "20.09"
}:
let
  pkgs_download = builtins.fetchTarball "https://github.com/NixOS/nixpkgs/archive/${tag}.tar.gz";
  pkgs = import pkgs_download {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };
  pypkgs = pkgs.python3Packages;
in
  pkgs.mkShell rec {
    buildInputs = with pypkgs; [
      scipy
      numpy
      matplotlib
      jupyter
      tkinter
      toolz
      ipywidgets
      pytorch
      torchvision
      pillow
      pkgs.cudatoolkit_11
      imageio
      pip
      h5py
    ];

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
      export version="455.45.01"
      export LD_PRELOAD=$CUDAPATH/libcuda.so.$version:$CUDAPATH/libnvidia-fatbinaryloader.so.$version:$CUDAPATH/libnvidia-ptxjitcompiler.so.$version:$CUDAPATH/libnvidia-ml.so.$version:$CUDAPATH/libcublas.so:$CUDAPATH/libcublasLt.so.10:$CUDAPATH/libstdc++.so.6
      export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt
      export CUDA_VISIBLE_DEVICES=0
      export CUDA_PATH=${pkgs.cudatoolkit_11} 
      export PATH=$CUDA_PATH:$PATH
      # To install extra packages use
      #
      # $ pip install --user <package>

    '';
  }
