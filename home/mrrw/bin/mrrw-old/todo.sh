#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/todo
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.

# The following line sources necessary variables:
. /home/$USER/bin/.sh.conf.sh 
list="todo"
msg="To Do:"
clearlist=""
cleardo=""

Help()
{
	#Display Help.
	echo "USAGE:  $script [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Manage a simple todo list."
	echo
	echo "OPTIONS:"
	echo "-C  Clear list."
	echo "-g	Add to grocery list."
	echo "-h	Display this help."
	echo "-n	Add to personal notes."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
#{{{
# Get the options:
while getopts ":ghnvxC" option; do
	case $option in
		g | --groceries)
			list="groc"     ;
			msg="Groceries:";;
		h | --help) 
			Help            ;
		 	exit            ;;
		n | --notes)
			list="note"     ;
			msg="Notes:"    ;;
		v | --verbose) 
			set -v          ;;
		x) 
			set -x          ;;
		C | --Clear)
			cleardo=y       ;;
	  \?) 
			echo "Error: Invalid option."
			exit
			;;
	esac
done
#}}}
# have $@ skip options:
# Create and access necessary files:
[[ ! -d ~/.todo ]] && mkdir ~/.todo
cd ~/.todo
[[ ! -a $list ]] && touch $list

###  MAIN PROGRAM EXECUTION

# Clear a list:
if [[ $cleardo == "y" ]]; then
	echo "Are you sure you want to clear $list?";
	read clearlist;
	if [ "$clearlist" = "y" ]; then
		rm $list;
		echo "Done.";
		exit;
	else
		echo "$clearlist";
		echo "OK, see ya.";
		exit
	fi
fi

# To avoid adding options to a list,
# shift positional parameters if -g or -n:
[[ -o g || n ]] && shift
# Add to a list:
if [[ -v 1 ]]; then 
  echo "$@ added to $list."
	echo -en "\t$@\n" >> $list;
	exit
else
	echo "$msg";
	cat $list;
	exit
fi

### EXPERIMENTAL CODE
# Source gitPush by mrrw:
#. /home/$USER/bin/gitPush.sh

###  ISSUES AND BUGS
# BUGS:
#    Seems to have some issues calling -C option properly,
#    started throwing errors when -C was implemented.
# To-Do:
#
