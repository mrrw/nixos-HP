#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
# Sources:
[[ -a ~/bin/.sh.conf.sh ]] . ~/bin/.sh.conf.sh 
[[ -a ~/bin/libmrrwCommands.sh ]] . ~/bin/libmrrwCommands.sh
#
Help()
{
	#Display Help.
	echo "USAGE:  $script [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Move and configure files en masse."
	echo
	echo "OPTIONS:"
	echo "-h	Display this help."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
#{{{
# Get the options:
while getopts ":hvx" option; do
	case $option in
		h | --help) 
			Help; exit
			;;
		v | --verbose) 
			set -v
			;;
		x) 
			set -x
			;;
	  \?) 
			echo "Error: Invalid option."
			exit
			;;
	esac
done
#}}}
# Set some variables:

###  MAIN PROGRAM EXECUTION

###  ISSUES AND BUGS
#
# To-Do:
