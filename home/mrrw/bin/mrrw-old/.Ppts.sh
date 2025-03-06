#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/Ppts.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
# The following line sources necessary variables:
. /home/$USER/bin/.sh.conf.sh 
		###  DEFINE VARIABLES
#~/bin/Ppts.sh
#~/var/Ppts/
#~/.config/Ppts/
#
fClist=/home/$USER/.ppts/chore.list
fCtmp=/home/$USER/.ppts/.chore.tmp
fPlist=/home/$USER/.ppts/person.list
fPtmp=/home/$USER/.ppts/person.list
info=""
PPdir=/home/$USER/.ppts/
tDay=$(date +%Y%j)
yDay=$(date -d yesterday +%Y%j)
Help()
{
	#Display Help.
	echo "USAGE:  $script [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Administer the Pick Points user tracking program."
	echo "Default behavior prints important data and exits."
	echo
	echo "OPTIONS:"
	echo "-a  Add chores, persons, events, rules, and other elements."
	echo "-c  View persons character sheet."
	echo "-h	Display this help."
	echo "-i  View persons inventory."
	echo "-l  View log and exit."
	echo "-p  Person management menu."
	echo "-q  Quiz a person."
	echo "-s  Print a summary and exit (default behavior)"
	echo "-x	Trace/Debug mode."
	echo "-v	Verbose mode."
	echo
}
		###  Get the options:
#{{{
while getopts ":chivxC" option; do
	case $option in
		c) # print CHARACTER section of <person>.dat
			shift
			info="$info\nc"
			;;
		h) # display help
			shift
			Help
			exit;;
		i) # print INVENTORY section of <person>.dat
			shift
			info="$info\ni"
			;;
		v) # verbose mode
			shift
			set -v;;
		x) # trace mode
			shift
			set -x;;
		C) # print CHARACTER section of <person>.dat
			shift
			info="$info\nC"
			;;
	  \?) # invalid option
			echo "Error: Invalid option."
			exit;;
	esac
done
#}}}

		###  DEFINE COMMANDS
ADMINstart()
{ #{{{
		# Print list of ppts files:
echo -e "Welcome to the Pick Points Program.\n"
echo "   FILE LIST:"
ls -A $PPdir
sleep 1
CheckChores
	echo -e "\n\tChecking chores..." && sleep .5
CheckPersons
	echo -e "\n\tChecking persons..." && sleep .5
} #}}}
CheckChores()
{ #{{{
[ ! -s $fCtmp ] && cat $fClist >> $fCtmp
cat $fCtmp
} #}}}
CheckChores()
{ #{{{
[ ! -s $fCtmp ] && cat $fClist >> $fCtmp
cat $fCtmp
} #}}}
CheckPersons()
{ #{{{
		# Create person list if it doesn't already exist:
[ ! -s /home/$USER/.ppts/person.list ] && GeneratePersons
		# prefill empty prsn files:
PS3="Choose a person
select p in $(cat $fPlist) ; do
			prsn=$PPdir'prsn-'$p.dat
			[ ! -s $prsn ] && echo "0" > $prsn 
			oldscore=$(sed -n '1p' $prsn)
		echo -en "\n\t\t$p"
		if [ $oldscore != "P" ] ; then
			echo -en " has $oldscore pickpoints"
		fi
				sed -n '/CHORES/,/^$/p'| sed 's/CHORES//' $prsn
	while getopts ":chivxC" option; do
		case $option in	
			c)
				echo -e "\tCurrent chores:"
				sed -n '/CHORES/,/^$/p' $prsn
				;;
			i)
				sed -n '/INVENTORY/,/^$/p' $prsn
				;;
			C)
				sed -n '/CHARACTER/,/^$/p' $prsn
				;;
		esac
	done
done
} #}}}
DoScore()
{ #{{{
oldscore=$(sed -n 'p1' .ppts/$prsn.dat)
score=$(expr $s + $s) 
#for prsn in $(ls | grep ".prsn") ; do
#	sed '1d' $prsn && echo $score | cat - $prsn > .tmp && mv .tmp $prsn && remove .tmp;
#done

} #}}}
GeneratePersons()
{ #{{{
	echo -en "Name the new persons, each seperated by a space:  "
read r 
for p in $r; do
		prsn=$PPdir'prsn-'$p.dat 
		if [ -s $prsn ] ; then
			echo "$p already exists."
			sleep 1
		else
			echo "$p" >> $fPlist
			echo -e "0\n\nCHARACTER\n\nINVENTORY\n" > $prsn 
		fi
	done
} #}}}
Pluck()
{ 
sed -n "${n}p" $file >> $destination
sed -i "${n}d" $file
}
Scrape()
{
sed -n "/$string/,/^$/p" $file | sed '1d;$d'
}
	# For scrape to work correctly, two important criteria:
	# 1.  lists must be titled correctly directly above the list;
	# 2.  lists must be followed by a newline.

		###  BEGIN PROGRAM EXECUTION
ADMINstart

##################################################
#ScoreCheck
#date +%Y%j
#
#echo -en "$child complete $task?"
#read t
#for p in $(ls | grep ".prsn") ; do cat $p; done 
