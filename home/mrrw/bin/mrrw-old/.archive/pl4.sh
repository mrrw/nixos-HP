#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/pl.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
. /home/$USER/bin/.sh.conf.sh

Help()
{
	#Display Help.
	echo "USAGE:  pl [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Create a datestamped personal log entry."
	echo
	echo "OPTIONS:"
	echo "-v	Verbose mode."
	echo "-x	Debug mode."
	echo "-h	Display this help."
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
		x) # debug mode
			set -x;;
	  \?) # invalid option
			echo "Error: Invalid option."
			exit;;
	esac
done

###  BEGIN USER CONFIGURATION

# Personal log .txt files are stored here:
DIR=~/Documents/
#####  END USER CONFIGURATION


###  BEGIN PROGRAM EXECUTION

# Make sure folding works:
set foldopen& #opens the fold that the cursur lands on.

# Make sure all logs are saved in ~/Documents:
if
	[[ ! -d "$DIR" ]];
then
	echo "$DIR does not exist.  Would you like to create this directory? [y/n]" && read d
	if
		[[ "$d" == "y" ]];
	then
		mkdir -p "$DIR" && cd "$DIR"; 
	else
		echo "See user configuration in ~/bin/pl.sh.  Goodbye." && exit;
	fi
else
	cd "$DIR";
fi

# Catagorize and name the document: 
echo "Select entry type: [f]reewriting, [i]nstructions, [l]yrics?";
read entrytypeIn
if [ $entrytypeIn == f ]; then
		entrynameIn=Freewriting;
	else
		echo "What shall we call this? (leave blank to abort):";
		read entrynameIn;
fi

if [ -z "$entrynameIn" ]; then
	exit; 
elif	[ $entrytypeIn == i ]; then
	  echo -en "\nCreate a new file, or add to an old one:\n\n" && sleep 1;
		ls -A $DIR | grep HELP | sed 's/HELP--//;s/.txt//';
		echo -en "\nType the name of the file:"
		read entrynameOut;
	else
		sleep 0
fi

# Create the document by type, using name:
case $entrytypeIn in
	f) 
		entrytypeOut="pl--"
		entrynameOut=`date +%F`
		title=$entrynameIn
		;;
	i)
		entrytypeOut="HELP--"
		title="Help:  "$entrynameIn
		;;
	l) 
		entrytypeOut="SING---"
		entrynameOut=$entrynameIn
		title=\"$entrynameIn\"\\n\\t"by Michael Milk"
		;;
	'') 
		entrytypeOut="pl--"
		entrynameOut=`date +%F`
		title=$entrynameIn
		;;
	*)
		entrytypeOut="pl--"
		entrynameOut=`date +%F`
		title=$entrynameIn
		;;
	esac


#NOTE: Placing $DOC in quotes allows for spaces in the title.
# Otherwise, .sh throws error 'ambiguous redirect.'

DIR=~/Documents/
entrytypeOut=".$user--"
entrynameOut=`date +%F`
title=$entrynameIn
DOC=$entrytypeOut$entrynameOut.txt
date +%c >> "$DOC"
echo -en "\t$title\n\n\n" >> "$DOC"
vim + -c startinsert "$DOC"
echo -en "\n**********\n" >> "$DOC"
echo "\"$DOC\" was modified:" && stat -c %y "$DOC"

###  BEGIN ISSUES

#####  END ISSUES
