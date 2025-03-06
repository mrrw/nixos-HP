#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/help.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
# The following line sources necessary variables:
# . /home/$USER/bin/.sh.conf.sh 
Help()
{
	#Display Help.
	echo "USAGE:  $script [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Call or add to user-made help files."
	echo
	echo "OPTIONS:"
	echo "-e	Edit a help file."
	echo "-h	Display this help."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
#{{{
# Get the options:
while getopts ":ehvx" option; do
	case $option in
		e | --edit)
			COMMAND=vim
			SUGGEST=edit
			;;
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

Exec_HELP()
{ #{{{
  #
COMMAND=
SUGGEST=
dir_lib="$HOME/lib/help"
if [ -z "$SUGGEST" ] ; then
	SUGGEST="view" ;fi
if [ -z "$COMMAND" ] ; then
	COMMAND="cat" ;fi
PS3="Which file would you like to $SUGGEST? ..."

###  MAIN PROGRAM EXECUTION
cd $dir_lib
select FILE in HELP*
do
		if [ "$COMMAND" != "vim" ] ; then 
			$COMMAND "$FILE" | less ;
		else
			$COMMAND "$FILE" ;
		fi
	break
done

} #}}}
