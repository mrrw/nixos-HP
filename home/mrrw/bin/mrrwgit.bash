#!/bin/bash
# ~/bin/mrrwgit.bash
# By mrrw (@mrrw.github), @2025, under GNU PUBLIC LICENSE.
set +x
	options='hipx'

Help()
{
	echo "   "
	echo "   USAGE: mrrwgit [-$options] "
	echo "   DESCRIPTION:  Manipulate system-wide git repository, found in root."
	echo "   "
	echo "   OPTIONS:"
	echo "   "
	echo "    -h --help       |  Print this help and exit. "
	echo "    -i --ignore     |  Edit /.gitignore ."
	echo "    -p --push       |  Add, commit, and push repo changes to head."
	echo "    -x --debug      |  Print script functions as they occur."
	echo "   "
}

# GET OPTIONS:
	while getopts ":$options" opt; do
		case ${opt} in
			h | --help)
				Help ; exit ;;
			i | --ignore)
				MRRWGIT_IGNORE=y ;;
			p | --push)
				MRRWGIT_PUSH=y ;;
			x | --debug)
				set -x ;
				shift ;;
			*)
				echo "Invalid option: -${OPTARG}." ;
				exit 1 ;;
		esac
	done

			

### INITIAL COMMANDS:
  FILEadd='/home /etc'
  f='/.gitignore /home /etc'

HOME_LIST()
{
	tree > .ls_$USER.txt

}
GIT_COMMIT()
{
	## BROKEN.  sudo bash -c echo "$s" > $cf:  PERMISSION DENIED?!
	#commitMessage=file  ## uncomment if you can fix GIT_COMMIT()
	commitMessage=  ## comment out if you can fix GIT_COMMIT()
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
MRRWGIT_IGNORE()
{
	sudo $EDITOR /.gitignore  # Repository found in root, requiring sudo.

}
MRRWGIT_PUSH()
{
	HOME_LIST
	cd /
	sudo git add $f  # Repository found in root, requiring sudo.
	GIT_COMMIT
	sudo git push -u origin main
}

### DEFAULT CODE EXECUTION:
if [ "$MRRWGIT_PUSH" = 'y' ] ; then
	MRRWGIT_PUSH
elif [ "$MRRWGIT_IGNORE" = 'y' ] ; then
	MRRWGIT_IGNORE
else
	Help
fi

#This repository tracks my first foray into nixos.  This is my personal backup (in case I REALLY donk things up and can't rollback somehow).  It's also public, for ease of access to myself and anyone interested in peeking or pinching my code.
