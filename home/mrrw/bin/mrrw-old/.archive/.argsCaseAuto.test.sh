#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/scribe.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.

# The following line sources necessary variables:
. /home/$USER/bin/.sh.conf.sh 

Help()
{
	#Display Help.
	echo "USAGE:  newScript [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Guides user in creating a bash script."
	echo
	echo "OPTIONS:"
	echo "-v	Verbose mode."
	echo "-h	Display this help."
	echo "-x	Debug mode."
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
###  COMMAND LISTS
Auto()
{
name="/home/$USER/bin/$1.sh"
echo "$name"
}

Walkthru()
{
	echo "Try adding an argument!"

case $@ in
	"")
	 Walkthru;;
	 *)	 
		 Auto;;
esac
###  BEGIN ISSUES

#####  END ISSUES
