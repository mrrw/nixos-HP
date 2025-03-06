#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/scribe.bash
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
###  VARIABLES
Help()
{
	#Display Help.
	echo "USAGE:  newScript [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Guides user in creating a bash script."
	echo
	echo "OPTIONS:"
	echo "-h	Display this help."
	echo "-l  Display log and exit."
	echo "-v	Verbose mode."
	echo "-x	Debug mode."
	echo
}
# Get the options:
#{{{
while getopts ":hvx" option; do
	case $option in
		h | --help)
			Help
			exit;;
		l | --log)
			less $log
			exit;;
		v) # verbose mode
			set -v
			shift
			;;
		x) # trace mode
			set -x
			shift
			;;
	  \?) # invalid option
			echo "Error: Invalid option."
			exit;;
	esac
done

#}}}
###  MAIN PROGRAM EXECUTION
[ ! -d $HOME/var/log ] && mkdir -p $HOME/var/log

name="$HOME/bin/${1-default}.bash"
s=$1
[ -s $name ] && vim $name && exit
echo "Create a description of the script, no longer than this."
read 's'
cd $HOME && cat $HOME/bin/.bash.TEMPLATE | sed "s/PROGRM/$1/g ; s/DSCR/$s/" > $name

echo "sudo chmod +x $name" && sudo chmod +x $name
alias "$1"="$name" && echo -e " # Added $(date '+%Y-%m-%d'): \nalias $1=\"$name\"" >> $HOME/.alias 
alias "$1"
$EDITOR $name
[ -s .zshistory ] && echo "$EDITOR $name" >> .zshistory


###  ISSUES & BUGS
###  CODE SNIPPETS
