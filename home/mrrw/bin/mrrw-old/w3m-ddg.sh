#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
	###  Sources:
#. /home/$USER/bin/.sh.conf.sh 
. /home/$USER/bin/libmrrwCommands.sh
#
	###  Files:
dir_var=$HOME/var/w3m-ddg
f_hist=$dir_var/w3m-ddg.hist
Help()
{
	#Display Help.
	echo "USAGE:  $script [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  quickly search the web using your favorite browser."
	echo "							Requires w3m."
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
			shift
			set -v
			;;
		x) 
			shift
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


# Holy relic:  +to+search+with+w3m&

###  MAIN PROGRAM EXECUTION
S1="www.duckduckgo.com/?q="
S2="&"
[ ! -d $dir_var ] && mkdir -p $dir_var
echo -en "$S1" >> $f_hist

while [[ $@ != "" ]] ; do 
	echo -en $(echo +$@ | awk '{print $1;}') >> $f_hist
	shift
done
echo -en "$S2\n" >> $f_hist
STRING=$(tail -n 1 "$f_hist" | sed 's/+//')

echo -en "$STRING"
w3m -o auto_image=FALSE "$STRING"
tail -n 1 .ddg-w3m.hist
ENGINE="www.duckduckgo.com/?q=$@&"

#echo "$SEARCHENGINE"
###  ISSUES AND BUGS
#
# To-Do:

