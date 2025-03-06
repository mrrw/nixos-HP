#!/bin/bash
set +v; set +x; set -e; set -u
# /home/mrrw/bin/chatGPTmrrw.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
# Required sources:
. /home/$USER/bin/.sh.conf.sh 
. /home/$USER/bin/libmrrwCommands.sh
#
Help()
{
	#Display Help.
	echo "USAGE:  $script [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Quickly access Shell-GPT, a chat-gpt cli tool. "
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
			shift
			;;
		x) 
			set -x
			shift
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
echo -en "\n$@\n" >> .sgpt.hist
STRING=$(tail -n 1 ".sgpt.hist") 
echo -en "$STRING"
echo
sgpt "$STRING"

###  ISSUES AND BUGS
#
# To-Do:
