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
            sed -i \
              -e "s|paths_to_remove.remove(auto_confirm)|#paths_to_remove.remove(auto_confirm)|"  \
              -e "s|self.uninstalled = paths_to_remove|#self.uninstalled = paths_to_remove|"  \
                $out/${pkgs.python35.sitePackages}/pip/req/req_install.py
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
          ln -s ${pythonPackages.python.interpreter} \
              $out/bin/${pythonPackages.python.executable}
          for dep in ${builtins.concatStringsSep " "
              (builtins.attrValues pkgs)}; do
            if [ -d "$dep/bin" ]; then
              for prog in "$dep/bin/"*; do
                if [ -x "$prog" ] && [ -f "$prog" ]; then
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
          ln -s ${pythonPackages.python.executable} \
              python3
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
        pythonPackages.buildPythonPackage (
          drv.drvAttrs // f drv.drvAttrs // { meta = drv.meta; }
        );
      withPackages = pkgs'':
        withPackages (pkgs // pkgs'');
    };

  python = withPackages {};

  generated = self: {
    "PyYAML" = python.mkDerivation {
      name = "PyYAML-3.12";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4a/85/db5a2df477072b2902b0eb892feb37d88ac635d36245a72a6a69b23b383a/PyYAML-3.12.tar.gz"; sha256 = "592766c6303207a20efc445587778322d7f73b161bd994f227adaa341ba212ab"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pyyaml.org/wiki/PyYAML";
        license = licenses.mit;
        description = "YAML parser and emitter for Python";
      };
    };

    "astroid" = python.mkDerivation {
      name = "astroid-1.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/11/3d/f3a2c581fe3fac017c72db8fec50c48a577c40721a51f62360a5bce2377b/astroid-1.6.0.tar.gz"; sha256 = "71dadba2110008e2c03f9fde662ddd2053db3c0489d0e03c94e828a0399edd4f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."lazy-object-proxy"
      self."six"
      self."wrapt"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/PyCQA/astroid";
        license = licenses.lgpl3;
        description = "A abstract syntax tree for Python with inference support.";
      };
    };

    "docopt" = python.mkDerivation {
      name = "docopt-0.6.2";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a2/55/8f8cab2afd404cf578136ef2cc5dfb50baa1761b68c9da1fb1e4eed343c9/docopt-0.6.2.tar.gz"; sha256 = "49b3a825280bd66b3aa83585ef59c4a8c82f2c8a522dbe754a8bc8d08c85c491"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://docopt.org";
        license = licenses.mit;
        description = "Pythonic argument parser, that will make you smile";
      };
    };

    "isort" = python.mkDerivation {
      name = "isort-4.2.15";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/4d/d5/7c8657126a43bcd3b0173e880407f48be4ac91b4957b51303eab744824cf/isort-4.2.15.tar.gz"; sha256 = "79f46172d3a4e2e53e7016e663cc7a8b538bec525c36675fcfd2767df30b3983"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/timothycrosley/isort";
        license = licenses.mit;
        description = "A Python utility / library to sort Python imports.";
      };
    };

    "lazy-object-proxy" = python.mkDerivation {
      name = "lazy-object-proxy-1.3.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/55/08/23c0753599bdec1aec273e322f277c4e875150325f565017f6280549f554/lazy-object-proxy-1.3.1.tar.gz"; sha256 = "eb91be369f945f10d3a49f5f9be8b3d0b93a4c2be8f8a5b83b0571b8123e0a7a"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/ionelmc/python-lazy-object-proxy";
        license = licenses.bsdOriginal;
        description = "A fast and thorough lazy object proxy.";
      };
    };

    "mccabe" = python.mkDerivation {
      name = "mccabe-0.6.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/06/18/fa675aa501e11d6d6ca0ae73a101b2f3571a565e0f7d38e062eec18a91ee/mccabe-0.6.1.tar.gz"; sha256 = "dd8d182285a0fe56bace7f45b5e7d1a6ebcbf524e8f3bd87eb0f125271b8831f"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/pycqa/mccabe";
        license = licenses.mit;
        description = "McCabe checker, plugin for flake8";
      };
    };

    "progressbar2" = python.mkDerivation {
      name = "progressbar2-3.34.3";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/2b/a4/f3928e11d2540c1ac92e7b2617fa512b6a4332c9cbbf4ebd13844e9cd8f8/progressbar2-3.34.3.tar.gz"; sha256 = "bdf07125292ed994215980e0859c22ac150338b72371b2c493fb2d6072e52fbe"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."python-utils"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/WoLpH/python-progressbar";
        license = licenses.bsdOriginal;
        description = "A Python Progressbar library to provide visual (yet text based) progress to long running operations.";
      };
    };

    "pykwalify" = python.mkDerivation {
      name = "pykwalify-1.6.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/ae/82/1774cdd9039301f20e36ae5bf36fa07683ac2d0c42a3d51cf3e0690210c1/pykwalify-1.6.0.tar.gz"; sha256 = "2298fafe84dc68161835f62a1b8d0d72dd749d5742baa196224882a6ac2ff844"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."PyYAML"
      self."docopt"
      self."python-dateutil"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/grokzen/pykwalify";
        license = licenses.mit;
        description = "Python lib/cli for JSON/YAML schema validation";
      };
    };

    "pylint" = python.mkDerivation {
      name = "pylint-1.8.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/16/4a/b6afd4098e521d2420d8dc9998690a3c17a059bc18b64c30141a07dc045e/pylint-1.8.1.tar.gz"; sha256 = "3035e44e37cd09919e9edad5573af01d7c6b9c52a0ebb4781185ae7ab690458b"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."astroid"
      self."isort"
      self."mccabe"
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/PyCQA/pylint";
        license = licenses.gpl1;
        description = "python code static checker";
      };
    };

    "python-dateutil" = python.mkDerivation {
      name = "python-dateutil-2.6.1";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/54/bb/f1db86504f7a49e1d9b9301531181b00a1c7325dc85a29160ee3eaa73a54/python-dateutil-2.6.1.tar.gz"; sha256 = "891c38b2a02f5bb1be3e4793866c8df49c7d19baabf9c1bad62547e0b4866aca"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://dateutil.readthedocs.io";
        license = licenses.bsdOriginal;
        description = "Extensions to the standard Python datetime module";
      };
    };

    "python-utils" = python.mkDerivation {
      name = "python-utils-2.2.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/19/f2/2c4c8c2a92325d0c70ef21647583179058ae64d07429e30ab2476624e40b/python-utils-2.2.0.tar.gz"; sha256 = "d9b8ab1f2a7c8f26ed16a47505f589a5d51c0d1e55869ab40c20e1c4b42af2c0"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [
      self."six"
    ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/WoLpH/python-utils";
        license = licenses.bsdOriginal;
        description = "Python Utils is a module with some convenient utilities not included with the standard Python install";
      };
    };

    "six" = python.mkDerivation {
      name = "six-1.11.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/16/d8/bc6316cf98419719bd59c91742194c111b6f2e85abac88e496adefaf7afe/six-1.11.0.tar.gz"; sha256 = "70e8a77beed4562e7f14fe23a786b54f6296e34344c23bc42f07b15018ff98e9"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://pypi.python.org/pypi/six/";
        license = licenses.mit;
        description = "Python 2 and 3 compatibility utilities";
      };
    };

    "vega" = python.mkDerivation {
      name = "vega-0.5.0";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/f8/50/54a1f852b72d45885dfde7f07950b7f5cd176dd551785b9b32725a004b0c/vega-0.5.0.tar.gz"; sha256 = "9871bce3a00bb775d9f7f8212aa237f99f11ca7cfe6ecf246773f5559f20c38c"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "http://github.com/vega/ipyvega/";
        license = licenses.bsdOriginal;
        description = "IPyVega: An IPython/Jupyter widget for Vega and Vega-Lite";
      };
    };

    "wrapt" = python.mkDerivation {
      name = "wrapt-1.10.11";
      src = pkgs.fetchurl { url = "https://pypi.python.org/packages/a0/47/66897906448185fcb77fc3c2b1bc20ed0ecca81a0f2f88eda3fc5a34fc3d/wrapt-1.10.11.tar.gz"; sha256 = "d4d560d479f2c21e1b5443bbd15fe7ec4b37fe7e53d335d3b9b0a7b1226fe3c6"; };
      doCheck = commonDoCheck;
      buildInputs = commonBuildInputs;
      propagatedBuildInputs = [ ];
      meta = with pkgs.stdenv.lib; {
        homepage = "https://github.com/GrahamDumpleton/wrapt";
        license = licenses.bsdOriginal;
        description = "Module for decorators, wrappers and monkey patching.";
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