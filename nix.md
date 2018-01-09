# Nix Notes

## Nice Tutorials

https://gricad.github.io/calcul/nix/tuto/2017/07/04/nix-tutorial.html#install-nix-single-user-mode



## After Installing

Set up Nix so that you just need to do `source ~/nix.sh` to use it

    $ cp /nix/var/nix/profiles/default/etc/profile.d/nix.sh ~/nix.sh
    
Trying this:

   $ echo "export PATH=/nix/var/nix/profiles/default/bin:/bin" >> ~/nix.sh

instead of this:

    $ echo "export PATH=/nix/var/nix/profiles/default/bin:\$PATH" >> ~/nix.sh
    
to keep it more pure. Also add this env variable, which is useful:

    $ echo "export NIX_USER_PROFILE_DIR=/nix/var/nix/profiles/per-user/\$USER " >> ~/nix.sh
    
Not putting it in `.bashrc` as it is too confusing until I'm using Nix for my primary work environmen. I'm still using Conda currently.

## Profiles

To start use an old profile or start a new one use

    $ nix-env --switch-profile $NIX_USER_PROFILE_DIR/<profile-name>

To see which profile you are currently using

    $ ls -altr ~/.nix-profile
    
To see a list of all possible profiles

    $ ls -al $NIX_USER_PROFILE_DIR
    
To clone a profile use

    $ cp -r $NIX_USER_PROFILE_DIR/<profile-name> $NIX_USER_PROFILE_DIR/<new-profile-name>

This seems to work, but I can't find documentation for this. It doesn't have any generations but makes a new generation after something is installed

## Generations

How to roll back

    $ nix-env --list-generations
    
to go to a particular generation

    $ nix-env --switch-generation <generation-number>
    
## Packages

List packages

    $ nix-env -q
    
Install `nix-env -i <package>` and uninstall `nix-env -e <package>`.

## Building a Package

To build use

    $ nix-build builder.nix
    
and to install

    $ nix-env -i ./result
    
and to debug

    $ nix-shell --pure builder.nix
    



