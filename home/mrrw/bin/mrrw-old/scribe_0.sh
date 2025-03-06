###
#!/bin/sh
set +v; set +x; set -e; set +u
# set -u # exit if no positional parameters provided by user.
# ~/bin/scribe.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
   ###  SOURCES
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
   ###  VARIABLES
dir_home=$HOME/scribe
dir_conf=$HOME/.scribe
dir_lib=$HOME/lib/scribe
dir_var=$HOME/var/scribe
file_conf_0=$HOME/.config/scribe/scribe.conf
file_log_0=$HOME/var/log/scribe.log
name="$HOME/bin/${1-default}.sh"
s=$1
   ###  LOGS
[ -s $file_log_0 ] && cp $file_log_0 > $file_log_0.0
touch $file_log_0
exec 3<> $file_log_0             # Open log under file descriptor 3
exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> /dev/pts/4              # Open tty 4 for sending user messages, fd 4
#exec 1>&4                        # OPTIONAL:  Send all stdout to tty 4
#
Help()
{
	#Display Help.
	echo "USAGE:  scribe [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  scribe 2"
	echo
	echo "OPTIONS:"
	echo "-h	Display this help and exit."
	echo "-l	Display log and exit."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
#{{{ ------ Help
# Get the options:
while getopts ":hlvx" option; do
	case $option in
		h | --help) 
			Help; exit
			;;
		l | --log) 
			less $file_log_0; exit
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
	echo "Initializing scribe."
	echo "$(date +%a_%m%d%y_%T) Initializing scribe... " >&3 
	# Create program files and directories:
#[ ! -d $dir_var ] && mkdir -p $dir_var
[ ! -d $dir_lib ] && mkdir -p $dir_lib
#[ ! -d $dir_conf ] && mkdir -p $dir_conf
	# Refresh log files:
	# Launch main program:
App_MAIN
	echo "Exiting scribe."
	echo "$(date +%a_%m%d%y_%T) ...exiting scribe." >&3 && exit

} #}}}
App_MAIN()
{ #{{{ ----- App_MAIN
	#
	Check_NAME
	Create_SCRIPT

} #}}}
Check_NAME()
{ #{{{ ----- Check_NAME
	#
[ -s $name ] && echo "$name already exists." && exit

} #}}}
Create_SCRIPT()
{ #{{{ ----- Create_SCRIPT
	#
echo "Create a description of the script, no longer than this."
read 's'
cd $HOME && cat $HOME/bin/.sh.TEMPLATE | sed "s/PROGRM/$1/g ; s/DSCR/$s/" > $name
#echo -en "\techo \"DESCRIPTION:  $s \"\n" >> $name
echo "sudo chmod +x $name" && sudo chmod +x $name
alias "$1"="$name" && echo -e " # Added $(date '+%Y-%m-%d'): \nalias $1=\"$name\"" >> $HOME/.alias 
alias "$1"
$EDITOR $name

} #}}}
Create_COMMANDLIST()
{ #{{{ ----- Create_COMMANDLIST
	#
file_lib=$HOME/lib/scribe.lib
[ -s $file_lib ] && . $file_lib

} #}}}
   ###  PROGRAM EXECUTION
ACTIFY

###  MAIN PROGRAM EXECUTION

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
