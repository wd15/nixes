let
  nixpkgs = import ./nixpkgs_version.nix;
  pypkgs = nixpkgs.python36Packages;
  reflink = import ./reflink.nix { inherit pypkgs; };
  dvc = import ./dvc.nix { inherit pypkgs pypi2nix reflink; };
  pkgs = nixpkgs.pkgs;
  pypi2nix = (import ./requirements.nix { inherit pkgs; }).packages;
  other = with pypkgs; [ numpy pandas scipy ];
  sklearn = import ./sklearn.nix { inherit pypkgs; };
in
  nixpkgs.stdenv.mkDerivation {
    name = "env";
    buildInputs = [
      dvc
      pkgs.git
      pypi2nix.awscli
      pkgs.coreutils
      pkgs.groff
      pypkgs.boto3
      pkgs.stdenv
      pypkgs.pip
      sklearn
    ] ++ dvc.buildInputs ++ other;
    shellHook = ''
       SOURCE_DATE_EPOCH=$(date +%s)
       export PYTHONUSERBASE=$PWD/.local
       export USER_SITE=`python -c "import site; print(site.USER_SITE)"`
       export PYTHONPATH=$PYTHONPATH:$USER_SITE
       export PATH=$PATH:$PYTHONUSERBASE/bin
       #pip install --user package
     '';

  }
