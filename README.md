/README.me
By mrrw, @2025

TABLE OF CONTENTS:
    1. Preface
    2. Fetching the Repository
    3. Updating the Repository



        Chapter 1.  Preface

This repository tracks my first foray into nixos.  This is my personal backup (in case I REALLY donk things up and can't rollback somehow).  It's also public, for ease of access to myself and anyone interested in peeking at my code.



        Chapter 2.  Fetching the Repository

Are you mrrw, starting over on a new machine with NixOS?  Get you this repository!

    [NOTE:  The instructions here-in have not been tested.  Proceed with caution.]

Before fetching this repository, one must install NixOS onto their machine.
    Recommended method:  USB ISO, minimal install (no desktop)

Once it is installed, you'll have to manually change /etc/nixos/configuration.nix,
adding git, vim, & w3m to the packages list.  Then, run the following commands:
    $ su
    # cd /
    # git clone https://github.com/mrrw/[this.repository] 



        Chapter 3.  Updating the Repository

To update this repository, enter the following commands:
    $ su
    # cd /
    # git status
    # git add ...
    # git commit -a
    # git push -u origin main

