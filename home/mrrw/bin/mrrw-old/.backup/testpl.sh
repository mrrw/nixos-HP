#!/bin/bash							#!/bin/bash
set +v; set +x; set -e; set -u					set +v; set +x; set -e; set -u
# ~/bin/pl.sh							# ~/bin/pl.sh
# by Michael Milk (mrrw.github)					# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.				# See EOF for known issues and bugs.
							      >	. /home/$USER/bin/.sh.conf.sh
							      >
							      >	# CRITICAL NOTE:  This program uses sed to manage some variab
							      >	# do not edit the first 11 lines of this program with the fol
							      >	# if the program is throwing errors, manually set the followi
							      >	userDIR=y 
							      >	DOsed=n
							      >	d=n

Help()								Help()
{								{
	#Display Help.							#Display Help.
	echo "USAGE:  pl [--options]; [user input]; [user inp		echo "USAGE:  pl [--options]; [user input]; [user inp
	echo "DESCRIPTION:  Create a datestamped personal log		echo "DESCRIPTION:  Create a datestamped personal log
	echo								echo
	echo "OPTIONS:"							echo "OPTIONS:"
	echo "-v	Verbose mode."					echo "-v	Verbose mode."
							      >		echo "-x  Debug mode."
	echo "-h	Display this help."				echo "-h	Display this help."
	echo								echo
}								}

# Get the options:						# Get the options:
while getopts ":hv" option; do				      |	while getopts ":hvx" option; do
	case $option in							case $option in
		h) # display help						h) # display help
			Help								Help
			exit;;								exit;;
		v) # verbose mode						v) # verbose mode
			set -v;;							set -v;;
		x) # debug mode							x) # debug mode
			set -x;;							set -x;;
	  \?) # invalid option						  \?) # invalid option
			echo "Error: Invalid option."					echo "Error: Invalid option."
			exit;;								exit;;
	esac								esac
done								done

###  BEGIN USER CONFIGURATION				      |	#set some variables:

# Personal log .txt files are stored here:		      |	# This program will automatically store all files here: 
DIR=~/Documents/					      |	defaultDIR=~/Documents/
#####  END USER CONFIGURATION				      |	userDIR=
							      >	userDIRquery=


###  BEGIN PROGRAM EXECUTION					###  BEGIN PROGRAM EXECUTION

# Make sure folding works:				      <
set foldopen& #opens the fold that the cursur lands on.	      <
							      <
# Make sure all logs are saved in ~/Documents:			# Make sure all logs are saved in ~/Documents:
if								if
	[[ ! -d "$DIR" ]];				      |		[[ ! -d "$defaultDIR" ]] && [[ "$userDIRquery" == n ]
then							      |			echo "$defaultDIR does not exist.  Would you 
	echo "$DIR does not exist.  Would you like to create  |			read d
	if								if
		[[ "$d" == "y" ]];						[[ "$d" == "y" ]];
	then						      |			then
		mkdir -p "$DIR" && cd "$DIR"; 		      |				mkdir -p "$defaultDIR" && cd "$defaul
	else						      |			else
		echo "See user configuration in ~/bin/pl.sh.  |				DOsed=y;
							      >				echo -en "Type in your prefered direc
							      >				read userDIR;
							      >				mkdir -p $userDIR
							      >				cd $userDIR
	fi								fi
else							      |	elif
	cd "$DIR";					      |		[[ ! -d "$defaultDIR" ]] && [[ "$userDIRquery" == y ]
							      >			cd $userDIR
							      >		else
							      >		cd "$defaultDIR";
fi								fi

# Catagorize and name the document: 				# Catagorize and name the document: 
echo "Select entry type: [f]reewriting, [i]nstructions, [l]yr	echo "Select entry type: [f]reewriting, [i]nstructions, [l]yr
read entrytypeIn						read entrytypeIn
if [ $entrytypeIn == f ]; then				      |	if [ -z $entrytypeIn ]; then
							      >		exit;
							      >	  elif [ $entrytypeIn == f ]; then
		entrynameIn=Freewriting;					entrynameIn=Freewriting;
	else								else
		echo "What shall we call this? (leave blank t			echo "What shall we call this? (leave blank t
		read entrynameIn;						read entrynameIn;
fi								fi

if [ -z "$entrynameIn" ]; then					if [ -z "$entrynameIn" ]; then
	exit; 								exit; 
elif	[ $entrytypeIn == i ]; then				elif	[ $entrytypeIn == i ]; then
	  echo -en "\nCreate a new file, or add to an old one		  echo -en "\nCreate a new file, or add to an old one
		ls -A $DIR | grep HELP | sed 's/HELP--//;s/.t			ls -A $DIR | grep HELP | sed 's/HELP--//;s/.t
		echo -en "\nType the name of the file:"				echo -en "\nType the name of the file:"
		read entrynameOut;						read entrynameOut;
	else								else
		sleep 0								sleep 0
fi								fi

# Create the document by type, using name:			# Create the document by type, using name:
case $entrytypeIn in						case $entrytypeIn in
	f) 								f) 
		entrytypeOut="pl--"						entrytypeOut="pl--"
		entrynameOut=`date +%F`						entrynameOut=`date +%F`
		title=$entrynameIn						title=$entrynameIn
		;;								;;
	i)								i)
		entrytypeOut="HELP--"						entrytypeOut="HELP--"
		title="Help:  "$entrynameIn					title="Help:  "$entrynameIn
		;;								;;
	l) 								l) 
		entrytypeOut="SONG--"						entrytypeOut="SONG--"
		entrynameOut=$entrynameIn					entrynameOut=$entrynameIn
		title=\"$entrynameIn\"\\n\\t"by Michael Milk"			title=\"$entrynameIn\"\\n\\t"by Michael Milk"
		;;								;;
	'') 								'') 
		entrytypeOut="pl--"						entrytypeOut="pl--"
		entrynameOut=`date +%F`						entrynameOut=`date +%F`
		title=$entrynameIn						title=$entrynameIn
		;;								;;
	*)								*)
		entrytypeOut="pl--"						entrytypeOut="pl--"
		entrynameOut=`date +%F`						entrynameOut=`date +%F`
		title=$entrynameIn						title=$entrynameIn
		;;								;;
	esac								esac


#NOTE: Placing $DOC in quotes allows for spaces in the title.	#NOTE: Placing $DOC in quotes allows for spaces in the title.
# Otherwise, .sh throws error 'ambiguous redirect.'		# Otherwise, .sh throws error 'ambiguous redirect.'
DOC=$entrytypeOut$entrynameOut.txt				DOC=$entrytypeOut$entrynameOut.txt
date +%c >> "$DOC"						date +%c >> "$DOC"
echo -en "\t$title\n\n\n" >> "$DOC"				echo -en "\t$title\n\n\n" >> "$DOC"
vim + -c startinsert "$DOC"					vim + -c startinsert "$DOC"
echo -en "\n**********\n" >> "$DOC"			      <
echo "\"$DOC\" was modified:" && stat -c %y "$DOC"		echo "\"$DOC\" was modified:" && stat -c %y "$DOC"
. /home/$USER/bin/gitPush.sh					. /home/$USER/bin/gitPush.sh
							      >	if [[ $DOsed == y ]]; then
							      >		sed -i '1,13s/userDIR=n/userDIR=y/' ${BASH_SOURCE[0]}
							      >	else
							      >		exit
							      >	fi

###  BEGIN ISSUES						###  BEGIN ISSUES
							      >
							      >	#NOTE:  If the program is throwing errors, please read the 
							      >	# CRITICAL NOTE at the top of this program before proceeding 

#####  END ISSUES						#####  END ISSUES
