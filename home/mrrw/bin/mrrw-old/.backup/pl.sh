#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/pl.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.

Help()
{
	#Display Help.
	echo "USAGE:  pl [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Create a datestamped personal log entry."
	echo
	echo "OPTIONS:"
	echo "-v	Verbose mode."
	echo "-h	Display this help."
	echo
}

# Get the options:
while getopts ":hv" option; do
	case $option in
		h) # display help
			Help
			exit;;
		v) # verbose mode
			set -v;;
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


set foldopen& #opens the fold that the cursur lands on.
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

echo "What are we writing about?"
read entryname	                      #Left blank, will exit program.

if [ -z "$entryname" ]; then
	exit; else 
	date +%c >> pl--`date +%F`.txt; 
	echo "Add hashtags: [f]reewriting, [i]nstructions, [l]yrics?";
	read entrytypeIn
fi
	
echo -en "\t$entryname\n\n@" >> pl--`date +%F`.txt
case $entrytypeIn in
	f)
		entrytypeOut="#freewriting"
		;;

	i)
		entrytypeOut="#instructions"
		;;
	l)
		entrytypeOut="#lyrics"
		;;

	'')
		entrytypeOut=""
		;;

	*)
		entrytypeOut="#$entrytypeIn"
		;;
esac

echo -en "$entrytypeOut" >> `date +%F`.txt
echo -en "\n" >> pl--`date +%F`.txt

vim +/@ pl--`date +%F`.txt 

# push the new/modified file to git repo:
git add ~/Documents/*.txt
git commit -a -m "pl"
git push

# sed experiment:
#sed 's/^@//' ~/personlogs/`date +%F`.txt ~/personlogs/`date +%F`.txt &
###  BEGIN ISSUES

#####  END ISSUES
