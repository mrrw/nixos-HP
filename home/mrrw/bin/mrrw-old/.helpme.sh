#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/helpme.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.

# The following line sources necessary variables:
. /home/$USER/bin/.sh.conf.sh 

Help()
{
	#Display Help.
	echo "USAGE:  helpme [--options]; [user input]; [user input]"
	echo "DESCRIPTION: Run help .sh files from a currated list in ~/bin." 
	echo
	echo "OPTIONS:"
	echo "-v	Verbose mode."
	echo "-h	Display this help."
	echo "-x	Trace/Debug mode."
	echo
}

# Get the options:
while getopts ":hvx" option; do
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
echo "What would you like help with?"
ls -A /home/$USER/bin/helpme/ | sed 's/helpme.// ; s/.sh//'
read helpme
echo "OK, printing $helpme."


# Source gitPush by mrrw:
#. /home/$USER/bin/gitPush.sh

###  BEGIN ISSUES

#####  END ISSUES
