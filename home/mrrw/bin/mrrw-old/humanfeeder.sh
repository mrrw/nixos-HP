###
#!/bin/sh
set +v; set +x; set -e; set +u
# set -u # exit if no positional parameters provided by user.
# ~/bin/humanfeeder.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
   ###  SOURCES
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
   ###  VARIABLES
dir_home=$HOME/humanfeeder
dir_conf=$HOME/.config/humanfeeder
dir_lib=$HOME/lib/humanfeeder
dir_var=$HOME/var/humanfeeder
file_conf_0=$HOME/.config/humanfeeder/humanfeeder.conf
file_log_0=$HOME/var/log/humanfeeder.log
   ###  LOGS
exec 3<> $file_log_0             # Open log under file descriptor 3
exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> /dev/pts/4              # Open tty 4 for sending user messages, fd 4
#exec 1>&4                        # OPTIONAL:  Send all stdout to tty 4


#
Help()
{
	#Display Help.
	echo "USAGE:  humanfeeder [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Track user nutritional needs and help meet them."
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
ACTIFY()
{ #{{{ ----- ACTIFY
	#
	echo "Initializing humanfeeder."
	echo "$(date +%a_%m%d%y_%T) Initializing humanfeeder... " >&3 
	# Create files and directories:
#[ ! -d $dir_var ] && mkdir -p $dir_var
#[ ! -d $dir_lib ] && mkdir -p $dir_lib
#[ ! -d $dir_conf ] && mkdir -p $dir_conf
App_MAIN
	echo "Exiting humanfeeder."
	echo "$(date +%a_%m%d%y_%T) ...exiting humanfeeder." >&3 && exit

} #}}}
App_MAIN()
{ #{{{ ----- App_MAIN
	#
echo "hello world"

} #}}}
Check_USER()
{ #{{{ ----- Check_USER
	#
	echo

} #}}}
   ###  PROGRAM EXECUTION
ACTIFY

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
