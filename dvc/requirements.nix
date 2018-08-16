# generated using pypi2nix tool (version: 1.8.1)
# See more at: https://github.com/garbas/pypi2nix
#
# COMMAND:
#   pypi2nix -V 3.6 -r requirements.txt
#

{ pkgs ? import <nixpkgs> {}
}:

let

  inherit (pkgs) makeWrapper;
  inherit (pkgs.stdenv.lib) fix' extends inNixShell;

  pythonPackages =
  import "${toString pkgs.path}/pkgs/top-level/python-packages.nix" {
    inherit pkgs;
    inherit (pkgs) stdenv;
    python = pkgs.python36;
    # patching pip so it does not try to remove files when running nix-shell
    overrides =
      self: super: {
        bootstrapped-pip = super.bootstrapped-pip.overrideDerivation (old: {
          patchPhase = old.patchPhase + ''
            sed -i               -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"                -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"                  $out/${pkgs.python35.sitePackages}/pip/req/req_install.py
          '';
        });
      };
  };

  commonBuildInputs = [];
  commonDoCheck = false;

  withPackages = pkgs':
    let
      pkgs = builtins.removeAttrs pkgs' ["__unfix__"];
      interpreter = pythonPackages.buildPythonPackage {
        name = "python36-interpreter";
        buildInputs = [ makeWrapper ] ++ (builtins.attrValues pkgs);
        buildCommand = ''
          mkdir -p $out/bin
          ln -s ${pythonPackages.python.interpreter}               $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "               (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -f $prog ]; then
                  ln -s $prog $out/bin/`basename $prog`
                fi
              done
            fi
          done
          for prog in "$out/bin/"*; do
            wrapProgram "$prog" --prefix PYTHONPATH : "$PYTHONPATH"
          done
          pushd $out/bin
          ln -s ${pythonPackages.python.executable} python
          ln -s ${pythonPackages.python.executable}               python3
          popd
        '';
        passthru.interpreter = pythonPackages.python;
      };
    in {
      __old = pythonPackages;
      inherit interpreter;
      mkDerivation = pythonPackages.buildPythonPackage;
      packages = pkgs;
      overrideDerivation = drv: f:
        pythonPackages.buildPythonPackage (drv.drvAttrs // f drv.drvAttrs //                                            { meta = drv.meta; });
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {

    "GitPython" = python.mkDerivation {
      name = "GitPython-2.1.11";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/4d/e8/98e06d3bc954e3c5b34e2a579ddf26255e762d21eb24fede458eff654c51/GitPython-2.1.11.tar.gz"; sha256 = "8237dc5bfd6f1366abeee5624111b9d6879393d84745a507de0fda86043b65a8"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."gitdb2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/gitpython-developers/GitPython";
        license = licenses.bsdOriginal;
        description = "Python Git Library";
      };
    };



    "configparser" = python.mkDerivation {
      name = "configparser-3.5.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/7c/69/c2ce7e91c89dc073eb1aa74c0621c3eefbffe8216b3f9af9d3885265c01c/configparser-3.5.0.tar.gz"; sha256 = "5308b47021bc2340965c371f0f058cc6971a04502638d4244225c49d80db273a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docs.python.org/3/library/configparser.html";
        license = licenses.mit;
        description = "This library brings the updated configparser from Python 3.5 to Python 2.6-3.5.";
      };
    };



    "decorator" = python.mkDerivation {
      name = "decorator-4.3.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/6f/24/15a229626c775aae5806312f6bf1e2a73785be3402c0acdec5dbddd8c11e/decorator-4.3.0.tar.gz"; sha256 = "c39efa13fbdeb4506c476c9b3babf6a718da943dab7811c206005a4a956c080c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/micheles/decorator";
        license = licenses.bsdOriginal;
        description = "Better living through Python with decorators";
      };
    };



    "gitdb2" = python.mkDerivation {
      name = "gitdb2-2.0.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/b9/36/4bdb753087a9232899ac482ee2d5da25f50b63998d661aa4e8170acd95b5/gitdb2-2.0.4.tar.gz"; sha256 = "bb4c85b8a58531c51373c89f92163b92f30f81369605a67cd52d1fc21246c044"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."smmap2"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/gitpython-developers/gitdb";
        license = licenses.bsdOriginal;
        description = "Git Object Database";
      };
    };



    "jsonpath-rw" = python.mkDerivation {
      name = "jsonpath-rw-1.4.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/71/7c/45001b1f19af8c4478489fbae4fc657b21c4c669d7a5a036a86882581d85/jsonpath-rw-1.4.0.tar.gz"; sha256 = "05c471281c45ae113f6103d1268ec7a4831a2e96aa80de45edc89b11fac4fbec"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."decorator"
      self."ply"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/kennknowles/python-jsonpath-rw";
        license = licenses.asl20;
        description = "A robust and significantly extended implementation of JSONPath for Python, with a clear AST for metaprogramming.";
      };
    };



    "nanotime" = python.mkDerivation {
      name = "nanotime-0.5.2";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/d5/54/6d5924f59cf671326e7809f4b3f70fa8df535d67e952ad0b6fea02f52faf/nanotime-0.5.2.tar.gz"; sha256 = "c7cc231fc5f6db401b448d7ab51c96d0a4733f4b69fabe569a576f89ffdf966b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/jbenet/nanotime/tree/master/python";
        license = licenses.mit;
        description = "nanotime python implementation";
      };
    };



    "ntfsutils" = python.mkDerivation {
      name = "ntfsutils-0.1.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/19/13/9e69452e5583fd93999503e17c10d1357356d661084f7d3f4bc2786b3059/ntfsutils-0.1.4.tar.gz"; sha256 = "50c058ce3371a819606ff29e914e6555c4d6c2527bff0cd0ed20af5947703118"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/sid0/ntfs";
        license = licenses.bsdOriginal;
        description = "A Python module to manipulate NTFS hard links and junctions.";
      };
    };



    "ply" = python.mkDerivation {
      name = "ply-3.11";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/e5/69/882ee5c9d017149285cab114ebeab373308ef0f874fcdac9beb90e0ac4da/ply-3.11.tar.gz"; sha256 = "00c7c1aaa88358b9c765b6d3000c6eec0ba42abca5351b095321aef446081da3"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.dabeaz.com/ply/";
        license = licenses.bsdOriginal;
        description = "Python Lex & Yacc";
      };
    };



    "six" = python.mkDerivation {
      name = "six-1.11.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"; sha256 = "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/six/";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };



    "smmap2" = python.mkDerivation {
      name = "smmap2-2.0.4";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/ad/e9/0fb974b182ff41d28ad267d0b4201b35159619eb610ea9a2e036817cb0b8/smmap2-2.0.4.tar.gz"; sha256 = "dc216005e529d57007ace27048eb336dcecb7fc413cfb3b2f402bb25972b69c6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/gitpython-developers/smmap";
        license = licenses.bsdOriginal;
        description = "A pure python implementation of a sliding window memory map manager";
      };
    };



    "zc.lockfile" = python.mkDerivation {
      name = "zc.lockfile-1.3.0";
      src = pkgs.fetchurl { url = "https://files.pythonhosted.org/packages/f5/fe/efb94907d8b2b81c3beab1bd628ff67e310d82816b94aa00b52062727ea9/zc.lockfile-1.3.0.tar.gz"; sha256 = "96cb13769e042988ea25d23d44cf09342ea0f887083d0f9736968f3617665853"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://www.python.org/pypi/zc.lockfile";
        license = licenses.zpl21;
        description = "Basic inter-process locks";
      };
    };

  };
  localOverridesFile = ./requirements_override.nix;
  overrides = import localOverridesFile { inherit pkgs python; };
  commonOverrides = [

  ];
  allOverrides =
    (if (builtins.pathExists localOverridesFile)
     then [overrides] else [] ) ++ commonOverrides;

in python.withPackages
   (fix' (pkgs.lib.fold
            extends
            generated
            allOverrides
         )
   )