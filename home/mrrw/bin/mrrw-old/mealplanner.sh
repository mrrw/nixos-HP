###
#!/bin/sh
set +v; set +x; set -e; set +u
# set -u # exit if no positional parameters provided by user.
# ~/bin/mealplanner.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
   ###  SOURCES
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
   ###  VARIABLES
dir_home=$HOME/mealplanner
dir_conf=$HOME/.mealplanner
dir_lib=$HOME/lib/mealplanner
dir_var=$HOME/var/mealplanner
file_conf_0=$HOME/.config/mealplanner/mealplanner.conf
file_log_0=$HOME/var/log/mealplanner.log
   ###  OPEN LOGS
exec 3<> $file_log_0             # Open log under file descriptor 3
exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> /dev/pts/4              # Open tty 4 for sending user messages, fd 4
#exec 1>&4                        # OPTIONAL:  Send all stdout to tty 4


#
Help()
{
	#Display Help.
	echo "USAGE:  mealplanner [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Plan and meals and keep a food log."
	echo
	echo "OPTIONS:"
	echo "-h	Display this help and exit."
	echo "-l	Display log and exit."
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
		l | --log) 
			less $log; exit
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
   ###  PROGRAM COMMANDS
Gate()
{ #{{{
if [ ! -d $dir_0 ] ; then
	echo "You're using this program for the first time.  "
	echo "Would you like to create a directory?"
	read r && if [ $r = y ] ;then mkdir $dir_0 ; fi
	
	echo "Hello world.  MainCommanding \"$0\"." | $logpipe_0
fi
} #}}}
InitializeAndExit()
{ #{{{
    echo "Initializing mealplanner."
    echo "$(date +%a_%m%d%y_%T) Initializing mealplanner... " >&3

		## Create files and directories:
#[ ! -d $dir_var ] && mkdir -p $dir_var
#[ ! -d $dir_lib ] && mkdir -p $dir_lib
    echo "Exiting mealplanner."
    echo "$(date +%a_%m%d%y_%T) ...exiting mealplanner." >&3
		exit

#}}}
###  MAIN PROGRAM EXECUTION
InitializeAndExit

###  ISSUES AND BUGS
###  NOTES

###    ###  #########   #########   #        #
####  ####  ###     ##  ###     ##  ##      ##
# ###### #  ###     ##  ###     ##  ##      ##
##  ##  ##  #########   #########   ##  ##  ##
##      ##  ##  ###     ##  ###     ## #### ##
##      ##  ##    ###   ##    ###    ###  ###
##      ##  ##      ##  ##      ##   ##    ##
###    ###  ###    ###  ###    ###    #    #   
#
#### Code clippings

#while :; do #This while loop is always open.
#	sleep 60
#	echo "" | $tee -a $file_log_0
#done
MEAL PLANNER
food:
protn Split pea soup
carbs spaghetti
carbs pizza
protn pizza
vegtl pizza
protn chkn veggie patties
protn chkn parm
protn ramen w/ peas
carbs ramen w/ peas
protn chkn n rice
carbs chkn n rice
protn veggie-egg-n-potato pancakes
vegtl veggie-egg-n-potato pancakes
carbs veggie-egg-n-potato pancakes
protn hotdogs
protn corndogs and fish
carbs corndogs and fish
protn mac-n-chz-n-peas
carbs mac-n-chz-n-peas
protn hamburger helper
protn chkn-pot-pie
carbs chkn-pot-pie
protn subs
carbs subs
protn blts
carbs blts
protn fish
carbs pankakes
carbs waffles
protn corned-beef-hash and eggs
protn bacon and eggs
protn bacon and eggs
protn ommelette
vegtl ommelette
carbs potato salad
carbs macaroni salad
carbs waldorf salad
protn waldorf salad
carbs salad salad
vegtl salad
vegtl fresh pepper
vegtl fresh tomatoe
carbs fresh corn
carbs cooked corn
carbs canned corn
carbs frozen corn
corn, cooked from frozen
corn, cooked from can
corn, fresh
protn baked beans
carbs stuffing
cranberry sauce, jelly or whole
crackers n chz n meat
protn nuts and seeds
dried fruit
fruit, fresh
apples, banannas, berries
fruit, canned
peaches, pears, fruit salad
nilla wafers n milk
graham crackers n milk
protn milk
protn milk n juice
protn crackers n squeeze chz
protn crackers n cheese
fig cookies
cliff bars
nutrigrain bars



entree
side
dessert
breakfast
lunch
dinner
supper
2nd breakfast
afternoonsies

meal:
bkfst 07-10
2ndbr 10-12
noons 12-13
lunch 13-15
suppr 15-17
dinnr 17-20

prtn:
entre 5
sides 3
snack 2
dssrt 1


case $(date +%H) in

	07 | 08 | 09 | 10 ) 		lastmeal=meal && meal=bkfst 
		;;
	
esac


MealRecord()
{ #{{{

# 1st draft...


echo "What did $susr eat during $lastmeal?" 
select food in $(cat $file_food | grep -i $lastmeal) ; do
	echo
done


if [ $(tail -1 $file_foodlog) = "$meal" ] ; then
	PS3="Would you like to log $lastmeal for $susr?" && read q
	if [ $q = "y" ] ; then
		echo "what did they eat?" 
		select food in $(cat $file_food | grep -i $lastmeal) ; do
			echo
		done
		[ -z $food = "" ] && food=skipped
		echo -e "$user $meal was $status" >&3
	fi
fi
	
} #}}}
MealDesign()
{ #{{{
echo	

} #}}}
