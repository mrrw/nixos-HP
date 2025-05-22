#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/Ppts.bash
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
# The following line sources necessary variables:
#. /home/$USER/bin/.sh.conf.sh 
. /home/$USER/bin/libmrrwCommands.sh
#. /home/$USER/.ppts/ppts.conf
#
Help()
{
	#Display Help.
	echo "USAGE:  $script [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Track user tasks and rewards."
	echo
	echo "OPTIONS:"
	echo "-v	Verbose mode."
	echo "-h	Display this help."
	echo "-x	Trace/Debug mode."
	echo
}
### Set some variables:
#
### COMMANDS:
#
MenuMain()
{ #{{{ MenuMain
dHome=~/.ppts
dValues=~/.ppts/values
today=$(date +%A)
	echo "1) Fetch chores"
	echo "2) Create chores"
	echo "3) Assign chores to person "
	echo "4) Assign value to chores"
	echo "5) Generate chores list"
	echo "6) Check a person"
	echo "7) Add a person"
	echo "8) "
	echo -en "\tWhat would you like to do?\t"
	read qCommand
		case $qCommand in
			1) ChoreCheck ;;
			2) ChoreAddQ ;;
			3) ChoreAssign ;;
			4) ChoreValue ;;
			5) ChoreGenList ;;
			6) PersonCheck ;;
			7) PersonCreate ;;
		esac
} #}}}
MenuChore()
{ #{{{ MenuChore

	echo "1) Fetch chores"
	echo "2) Create chores"
	echo "3) Assign chores to person "
	echo "4) Assign value to chores"
	echo "5) Generate chores list"
	echo "6) Check a person"
	echo "7) Add a person"
	echo "8) "
	echo -en "\tWhat would you like to do?\t"
	read qCommand
		case $qCommand in
			1) ChoreCheck ;;
			2) ChoreAddQ ;;
			3) ChoreAssign ;;
			4) ChoreValue ;;
			5) ChoreGenList ;;
			6) PersonCheck ;;
			7) PersonCreate ;;
		esac
} #}}}
PptsEarn()
{ #{{{ PptsEarn

	d=$dValues && ADMINcd
	while [[ -s $f ]]; do
		ADMINclipLine
		score=$(cat * | grep -il "$s")
		if [ score = "" ] ; then
			AssignValue;
		else 
			echo "$score -- $s" >> $name.prsn
			echo "$score +" >> score.tmp
		fi
	done
	echo "0" >> score.tmp
	echo -en $(cat score.tmp)
	expr $(cat score.tmp)
	while [[ ! -s score.tmp ]]; do
		ADMINclipLine
		score=$(cat *.pts | grep -il "$s")
		if [ score = "" ] ; then
			AssignValue;
		else 
			echo "$score -- $s" >> $name.prsn
			echo "$score" >> score.tmp
		fi
	done
} #}}}
ChoreAssign()
{ #{{{ ChoreAssign

	while [[ -s $f ]] ; do
		ADMINclipLine;
		ps3="Who Will/Did complete this chore today?";
		select name in $(ls | grep *.prsn) ; do
			echo "$s" >> "$name.prsn";
		done
	done
} #}}}
ChoreCheck()
{ #{{{ ChoreCheck

	f=.chore.tmp
	echo -n "Checking $f for undone chores...  " && sleep 1;
	if [[ -s $f ]] ; then
		echo Found some!
		echo 
		ChoreAssign
	else
		echo "No chores found.  Fetching chores..." && sleep 1;
		ChoreGenList
	fi
} #}}}
ChoreAddQ()
{ #{{{ ChoreAddQ

		qChoreCreate=y
		while [ $qChoreCreate = "y" ] ; do
			ChoreCreate ; 
			echo "Would you like to add new chores?"
			read qChoreCreate
		done
#	if [ $qChoreCreate = "y" ] ; then
#		ChoreCreate ; else
		exit
	#fi
} #}}}
ChoreCreate()
{ #{{{ ChoreCreate

	n="1NewChoreCategory"
	touch "$n"
	echo "What's the name of the new chore?" && read chore
	echo "Is this a daily chore?" && read daily && echo
	if [ $daily = "y" ] ; then
			echo "By default, this chore will be done daily." && echo;
			day=Daily;
		else
			echo "By default, this chore will repeat $today's." && echo;
			day="$today";
	fi
	PS3="Categorize the new chore.  (this can be changed later)"
	select category in $(ls -A $dHome | grep -i chore); 
	do
		if [[ $category = $n ]] ; then 
			echo "Name the new category." && read category;
			echo "$day -- $chore" >> $category.chore;
			echo "Created $category.chore."
			echo "Added \"$chore\" to $category.chore."
		else
			echo "$day -- $chore" >> $category;
			echo "Added \"$chore\" to $category."
		fi
		rm "$n";
		break;
	done
} #}}}
ChoreGenList()
{ #{{{ ChoreGen

	if [ ! -s .chore.tmp ] ; then
		f=$(ls | grep chore);
	 	cat $f | grep -i daily >> .chore.tmp;
	 	cat $f | grep -i $today >> .chore.tmp&
		echo ; 
		echo -e "\tChores left to do:";
		cat .chore.tmp
	else
		echo ; 
		echo "No action taken.";
		echo ; 
		echo -e "\tChores left to do:";
		cat .chore.tmp
	fi
} #}}}
ChoreSelect()
{ #{{{ ChoreCheck

	f=.chore.tmp
	qChoreSelect=y
	while [ $qChoreSelect = "y" ] ; do
		select chore in $f ; do
			MenuChore
		done
	done
} #}}}
ChoreValue()
{ #{{{ AssingValue

	
	d=$dValues && ADMINcdForce
	f=$dHome/.chore.tmp
	while [[ -s $f ]] ; do
		head -n 1 "$f"
		echo "How many points is this chore worth?"
		echo -n "[number]:"
		read value
		echo
		echo $(head -n 1 $f) >> "$value"
		sed -i '1d' $f
	done
} #}}}
GeneratePersonList()
{ #{{{
pl=/home/$USER/.ppts/person.list
touch $pl
echo "List your household members, each seperated by a space:  " 
read r
for p in $r; do
		touch "$p.prsn" 
		echo "$p" >> $pl
	done
} #}}}
PersonCheck()
{ #{{{ PersonCheck
	
	names=$(echo "$(tree -if | grep prsn)")
	if [ -z $names ] ; then
		echo none && PersonCreate; else
		echo found && PersonSelect;
	fi


} #}}}
PersonCreate()
{ #{{{ PersonCreate

	echo "What is the person's first name?"
	read name
	if [ "$name.prsn" == "$(ls | grep "$name")" ] ; then
		echo "That name is already taken.  Choose another.";
		read name;
		touch "$name.prsn"
	else
		touch "$name.prsn"
	fi
	PersonSelect
} #}}}
PersonSelect()
{ #{{{ PersonSelect

		ps3="Select a person."
		select name in $(ls | grep *.prsn) ; do
			$qCommand
		done
} #}}}
#}}}
# Get the options:
#{{{
while getopts ":aghlqvx" option; do
	case $option in
		a | --addRecipient)
			addRecipient
			;;
		g | --generateQuestions)
			generateQuestions
			;;
		h | --help) # display help
			Help
			exit;;
		l | --loadRecipient)
			loadRecipient
			;;
		q | --answerQuestions)
			answerQuestions
			;;
		v) # verbose mode
			set -v;;
		x) # trace mode
			set -x;;
	  \?) # invalid option
			echo "Error: Invalid option."
			exit;;
	esac
done

#}}}
###  BEGIN PROGRAM EXECUTION
d=$dHome && ADMINcdForce
MenuMain
