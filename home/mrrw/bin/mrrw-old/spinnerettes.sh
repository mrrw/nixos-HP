###
#!/bin/sh
# ~/bin/spinnerettes.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
set +v; set +x; set -e; set +u
# set -u # exit if no positional parameters provided by user.
   ###  SOURCES
. $HOME/bin/.sh.conf.sh 
. $HOME/bin/libmrrwCommands.sh
   ###  VARIABLES
dir_lib=$HOME/lib/spinnerettes
dir_var=$HOME/var/spinnerettes
file_conf_0=$HOME/.config/spinnerettes.conf
file_log_0=$HOME/var/log/spinnerettes.log
tmuxpane_messages=$(tmux list-panes -a -F '#{pane_tty}' | awk '{ print $0 }' | head -n 4 | tail -n 1)
   ###  LOGS
exec 3<> $file_log_0             # Open log under file descriptor 3
exec 2>&3
exec 4<> $tmuxpane_messages              # Open tty for sending user messages, fd 4


#
Help()
{
	#Display Help.
	echo "USAGE:  spinnerettes [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Schedule your environment.  Schedule once a day in cron."
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
	# Check core files and directories, start main program.
	#
echo -e "\n$(date +%a_%m%d%y_%T) Starting spinnerettes..." >&3
echo " ...starting spinnerette-daemon and terminating spinnerettes.sh."
	Check_APPS&
exit

}  #}}}
Check_APPS()
{ #{{{ ----- Check_APPS
	# Scan list of apps to run, both daemons and periodical instances.
echo "$(date +%a_%m%d%y_%T) Scanning run-list every 60 seconds..." >&3
while :; do #This while loop is always open.
		 ### Daemons:
		radiod
		 ### Periodical Instances:
		moveFiles
	sleep 60
done

} #}}}
moveFiles()
{ #{{{
	mv $HOME/*scrot* ~/usr/Images 2>/dev/null&
	mv $HOME/*--* ~/lib/help 2>/dev/null&

} #}}}
radiod()
{ #{{{
s=$HOME/bin/radio.sh
if [ -z $(ps ax |grep $s| grep -iv grep | head -n 1 | awk '{ print $1 }') ] ; then
	echo "$(date +%a_%m%d%y_%T) Initializing radiod." >&3
	sh -c $s
fi

} #}}}
   ###  PROGRAM EXECUTION
ACTIFY

	###  ISSUES AND BUGS
		# * What goals for this program?
		#  - start radiod
		#  - make anouncements
		#  - meal planner
		#  - chore planner
		#  - ppts score-keeper
		#  - turn-taker
		#  - pick timer
		#  - goal tracker
		#  - file archival
		#  - neofetch
		#  - gamification
		#  - subusers in realtime
		
	###  NOTES
	  # This program is designed to be run however frequently is appropriate.
		# It could be called on startup, periodically through cron, or as it's own daemon.
		#

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

#Radiod
#Soundmind
#Terminate

#TestCommand
#{ #{{{
#} #}}}

#while [[ $(date +%H) <= 7 ]] ; do #This while loop is time-dependant.
#done
