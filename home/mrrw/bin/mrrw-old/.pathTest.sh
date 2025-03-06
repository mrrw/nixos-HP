#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.

# The following line sources necessary variables:
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
#{{{
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
#}}}

###  BEGIN USER CONFIGURATION

#####  END USER CONFIGURATION


###  BEGIN PROGRAM EXECUTION
echo "Name of this script:"
echo $0
echo "Full path address:"
echo ${BASH_SOURCE[0]}
echo "1st argument:"
echo $1

# Source gitPush by mrrw:
#. /home/$USER/bin/gitPush.sh

###  BEGIN ISSUES

#####  END ISSUES
