#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/gamers.sh
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
	echo "DESCRIPTION:  Assign numbers to any amount of players."
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

dad=1 ben=2 nathan=3 amelia=4
echo -en "\n\nDad = 1\nBen = 2\nNathan = 3\nAmelia = 4\n\n"
