#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/gitPush.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
. /home/$USER/bin/.sh.conf.sh

Help()
{
	#Display Help.
	echo "USAGE:  pl [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Create a datestamped personal log entry."
	echo
	echo "OPTIONS:"
	echo "-v	Verbose mode."
	echo "-h	Display this help."
	echo "-x	Trace/Debug mode."
	echo
}

# Get the options:
while getopts ":hv" option; do
	case $option in
		h) # display help
			Help
			exit;;
		v) # verbose mode
			set -v;;
		x) # trace mode
			set -x;;
	  \?) # invalid option
			echo "Error: Invalid option."
			exit;;
	esac
done

###  BEGIN USER CONFIGURATION

#####  END USER CONFIGURATION


###  BEGIN PROGRAM EXECUTION

Exec_GITstuff()
{ #{{{
  #
git add /home/$USER/Documents/
git add /home/$USER/bin
git commit -a -m "pl" 
#sed '1s/^/pl' /home/$USER/.git/COMMIT_EDITMSG
#sed 'i/Created $name' /home/$USER/.git/COMMIT_EDITMSG
echo "Pulling from repo (no rebase, of course)..."
git pull --no-rebase
echo "Pushing to repo..."
git push

} #}}}
