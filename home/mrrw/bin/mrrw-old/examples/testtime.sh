###
#!/bin/sh
set +v; set +x; set -e; set +u
# set -u # exit if no positional parameters provided by user.
# ~/bin/testtime.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
   ###  SOURCES
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
   ###  VARIABLES
dir_home=$HOME/testtime
dir_conf=$HOME/.testtime
dir_lib=$HOME/lib/testtime
dir_var=$HOME/var/testtime
file_conf_0=$HOME/.config/testtime/testtime.conf
file_log_0=$HOME/var/log/testtime.log
   ###  LOGS
exec 3<> $file_log_0             # Open log under file descriptor 3
exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> /dev/pts/4              # Open tty 4 for sending user messages, fd 4
#exec 1>&4                        # OPTIONAL:  Send all stdout to tty 4


#
Help()
{
	#Display Help.
	echo "USAGE:  testtime [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  none"
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
	
	echo "Hello world.  Initializeing \"$0\"." | $logpipe_0
fi
} #}}}
Actify()
{ #{{{
	echo "Initializing testtime."
	echo "$(date +%a_%m%d%y_%T) Initializing testtime... " >&3 
	# Create files and directories:
#[ ! -d $dir_var ] && mkdir -p $dir_var
#[ ! -d $dir_lib ] && mkdir -p $dir_lib
App_MAIN
	echo "Exiting testtime."
	echo "$(date +%a_%m%d%y_%T) ...exiting testtime." >&3 && exit

} #}}}
App_MAIN()
{ #{{{
read -p "Date in (HHMM) format: " inputdate
numDate=$(date -d "$inputdate" +"%H%M")
case $((
	(numDate >= 0600 && numDate <= 1200) * 1 +
	(numDate >= 1300 && numDate <= 1800) * 2 +
	(numDate >= 1800 && numDate <= 2200) * 3 +
	(numDate >= 2200 && numDate <= 0500) * 4)) in
	(1) echo "Good Morning";;
	(2) echo "Good Afternoon";;
	(3) echo "Good Evening";;
	(4) echo "Goodnight";;
	(0) echo "WTF time is it anyhow?";;
esac

} #}}}
   ###  PROGRAM EXECUTION
Actify

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
