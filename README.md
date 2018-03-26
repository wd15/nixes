Trying to use Nix to build the PFHub website based on the exisisting [`travis.yml`](https://github.com/usnistgov/chimad-phase-field/blob/master/.travis.yml), which doesn't use Nix.

## Usage

[Install Nix](https://nixos.org/nix/manual/#chap-quick-start).

and then clone PFHub and this Gist.

    $ git clone https://github.com/usnistgov/chimad-phase-field.git
    $ git clone https://gist.github.com/wd15/ee4beac60b4efb4b1d7c581ee435eccd pfhub-nix
    $ cd pfhub-nix
    $ nix-shell
    [nix-shell]$ cd ../chimad-phase-field
    [nix-shell]$ jekyll serve
    
## Update the installation files

This uses [Bundix](https://github.com/manveru/bundix).

Update the `Gemfile` if necessary and then

    $ nix-shell -p bundler
    [nix-shell]$ bundler package --no-install --path vendor
    [nix-shell]$ rm -rf .bundler vendor
    [nix-shell]$ exit
    $ $(nix-build '<nixpkgs>' -A bundix)/bin/bundix
    $ rm result
    
This updates the installed gems.