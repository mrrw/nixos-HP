###
#!/bin/sh
set +v; set +x; set -e; set +u
# set -u # exit if no positional parameters provided by user.
# ~/bin/lifetree.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
   ###  SOURCES
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
   ###  VARIABLES
dir_home=$HOME/lifetree
dir_conf=$HOME/.config/lifetree
dir_lib=$HOME/lib/lifetree
dir_var=$HOME/var/lifetree
file_conf_0=$HOME/.config/lifetree/lifetree.conf
fc0=$file_conf_0
file_log_0=$HOME/var/log/lifetree.log
   ###  LOGS
exec 3<> $file_log_0             # Open log under file descriptor 3
exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> /dev/pts/4              # Open tty 4 for sending user messages, fd 4
#exec 1>&4                        # OPTIONAL:  Send all stdout to tty 4
   ###  LOAD PROGRAM
d0=""
[ -s $file_conf_0 ] && . $file_conf_0


#
Help()
{
	#Display Help.
	echo "USAGE:  lifetree [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Create, review, and adjust a comprehensive planner and to-do."
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
Activate()
{ #{{{ ----- Activate
	echo "Initializing lifetree."
	echo "$(date +%a_%m%d%y_%T) Initializing lifetree... " >&3 
	# Create files and directories:
[ ! -d $dir_var ] && mkdir -p $dir_var
[ ! -d $dir_lib ] && mkdir -p $dir_lib
App_MAIN

	echo "Exiting lifetree."
	echo "$(date +%a_%m%d%y_%T) ...exiting lifetree." >&3 && exit

} #}}}
App_MAIN()
{ #{{{ ----- App_MAIN
	Begin

} #}}}
Begin()
{ #{{{ ----- Begin
	echo "Welcome to lifetree."
[ ! -d $dir_conf ] && mkdir $dir_conf 
touch $file_conf_0 
if [ ! -s $file_conf_0 ] ; then
	echo "What's your first name?"
	User_MAKE
fi
	d=$dir_lib && cd $d
	Choose

} #}}}
Choose()
{ #{{{ ----- Choose
	PS3="Please choose a subject."
	select s in $(ls) ; do
		if [ -d $s ] ; then
		 	cd $s
		else
			less $s
		fi
	done <2&

} #}}}
Dive()
{ #{{{ ----- Dive
	cd $s
	if [ ! -s $(ls) ] ; then
		PS3="Select an element to adjust."
		Extract
	else
		PS3=""
	fi

} #}}}
Extract()
{ #{{{ ----- Extract
	cd $s
	if [ -s $(ls) ] ; then
		PS3="Select an element to adjust."
		Choose
	else
		PS3="What would you like to focus on?"
		Focus
	fi

} #}}}
Focus()
{ #{{{ ----- Focus
	cd $s
	if [ -s $(ls) ] ; then
		Choose
	else
		echo "what"

	fi

} #}}}
User_CHECK()
{ #{{{ ----- User_CHECK
	PS3="Choose a subject."
	select u in $(cat $fc0) ; do

	done

} #}}}
User_MAKE()
{ #{{{ ----- User_MAKE
	read u
	echo u >> $fc0

} #}}}
   ###  PROGRAM EXECUTION
Activate

#Exit program:

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
