# PFHub Nix Expression

Nix expression to host the [PFHub website](https://github.com/usnistgov/pfhub).

# Usage

Follow the [Nix notes](../NIX-NOTES.md) for installing Nix. After
installing Nix and cloning this repository, run

    $ nix-shell

in this directory. At that point, you should be able to run all the
functionality in the [PFHub `travis.yml`
file](https://github.com/usnistgov/pfhub/blob/master/.travis.yml)
including

    $ jekyll serve

to view the website locally.

## Update Packages

The dependencies are all fixed in the above installation. To update
the Python, Ruby and Javascript dependencies use the following

### Ruby

Using [Bundix](https://github.com/manveru/bundix).

Update the `Gemfile` if necessary and then

    $ nix-shell -p bundler
    [nix-shell]$ bundler package --no-install --path vendor
    [nix-shell]$ rm -rf .bundler vendor
    [nix-shell]$ exit
    $ $(nix-build '<nixpkgs>' -A bundix)/bin/bundix
    $ rm result

This updates the installed gems.

### Python

Using [pypi2nix](https://github.com/garbas/pypi2nix).

    $ pypi2nix -V "3.6" -r requirements.txt

### Javascript

Install [node2nix](https://github.com/svanderburg/node2nix).

    $ nix-env -f '<nixpkgs>' -iA nodePackages.node2nix

Then run

    $ node2nix --input node-packages.json --output node-packages.nix --composition node.nix

Edit `node.nix` and replace `nodejs-4_x` with `nodejs` in the 5th
line.