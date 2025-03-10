#!/bin/bash
# ~/bin/gitpush.bash
# By mrrw, @2025 --no rights reserved
# set -x

# Repository found in root, requiring sudo.

### INITIAL COMMANDS:
f='/home /etc'
#commitMessage=file  ## uncomment if you can fix GIT_COMMIT()
commitMessage=  ## comment out if you can fix GIT_COMMIT()

GIT_COMMIT()
{
	## BROKEN.  sudo bash -c echo "$s" > $cf:  PERMISSION DENIED?!
	if [ $commitMessage = "file" ] ; then
		cf=~/var/tmp.txt && sudo touch $cf
		sudo git status
		echo "Write a commit message no longer than this: -----------|"
		read s && sudo bash -c echo "$s" > $cf
		sudo git commit -F $cf
		sudo rm -f $cf
	else
		sudo git commit -a
	fi
}

### EXECUTE CODE:
cd /
sudo git add $f
GIT_COMMIT
sudo git push -u origin main

#This repository tracks my first foray into nixos.  This is my personal backup (in case I REALLY donk things up and can't rollback somehow).  It's also public, for ease of access to myself and anyone interested in peeking or pinching my code.
