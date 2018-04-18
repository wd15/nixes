# Nix Notes

## Nice Tutorial

Use this tutorial to get started with Nix

https://gricad.github.io/calcul/nix/tuto/2017/07/04/nix-tutorial.html#install-nix-single-user-mode

## After Installing

Set up Nix so that you just need to do `source ~/nix.sh` to use it

    $ cp ~/.nix-profile/etc/profile.d/nix.sh ~/nix.sh

Update permisssions:

    $ chmod +w ~/nix.sh

Do this for purity:

    $ echo -e "unset PATH\n$(cat ~/nix.sh)" > ~/nix.sh

Update the path again

    $ echo "export PATH=\$PATH:/nix/var/nix/profiles/default/bin:/bin:/usr/bin" >> ~/nix.sh

Also add this env variable, which is useful:

    $ echo "export NIX_USER_PROFILE_DIR=/nix/var/nix/profiles/per-user/\$USER " >> ~/nix.sh

Set up the man pages correctly:

    $ echo "export MANPATH=/nix/var/nix/profiles/default/share/man:\$HOME/.nix-profile/share/man:\$MANPATH" >> ~/nix.sh
To start using Nix use

    $ source ~/nix.sh

## Profiles

To start use an old profile or start a new one use

    $ nix-env --switch-profile $NIX_USER_PROFILE_DIR/<profile-name>

To see which profile you are currently using

    $ ls -altr ~/.nix-profile

To see a list of all possible profiles

    $ ls -al $NIX_USER_PROFILE_DIR

To clone a profile use

    $ cp -r $NIX_USER_PROFILE_DIR/<profile-name> $NIX_USER_PROFILE_DIR/<new-profile-name>

This seems to work, but I can't find documentation for this. It
doesn't have any generations but makes a new generation after
something is installed

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
