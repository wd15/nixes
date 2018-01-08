# Nix Notes

## After Installing

Set up Nix so that you just need to do `source ~/nix.sh` to use it

    cp /nix/var/nix/profiles/default/etc/profile.d/nix.sh ~/nix.sh
    echo "export PATH=/nix/var/nix/profiles/default/bin:\$PATH" >> ~/nix.sh
    echo "export NIX_USER_PROFILE_DIR=/nix/var/nix/profiles/per-user/\$USER " >> ~/nix.sh
    
Not putting it in `.bashrc` as it is too confusing until I'm using Nix for my primary work environmen. I'm still using Conda currently.



