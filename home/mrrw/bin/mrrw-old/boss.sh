###
#!/bin/sh
set +v; set +x; set -e; set +u
# set -u # exit if no positional parameters provided by user.
# ~/bin/boss.sh
# by Michael Milk (mrrw.github)
#
 #
  #
   #
   ###  SOURCES
   #
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
   #
   ###  FILES AND DIRECTORIES
   #
dir_conf=$HOME/.config/boss
dir_home=$HOME/boss
dir_lib=$HOME/lib/boss && lib=$dir_lib
dir_log=$HOME/var/log
dir_var=$HOME/var/boss && var=$dir_var
file_conf_0=$HOME/.config/boss/boss.conf
file_log_0=$HOME/var/log/boss.log
	 #
   ###  LOGS
	 #
file_log_0=$HOME/var/log/boss_0.log && fl0=$file_log_0
file_log_1=$HOME/var/log/boss_1.log && fl1=$file_log_1
file_log_2=$HOME/var/log/boss_2.log && fl2=$file_log_2
   # curate logs by age:
[ -s $fl1 ] && mv $fl1 $fl2
[ -s $fl0 ] && mv $fl0 $fl1
   # open main log:
exec 3<> $fl0                    # Open log under file descriptor 3
   # redirection:
exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> /dev/pts/4              # Open tty 4 for sending user messages, fd 4
#exec 1>&4                        # OPTIONAL:  Send all stdout to tty 4
	 #
	 ###  HELP AND OPTIONS
	 #
Help()
{
	#Display Help.
	echo "USAGE:  boss [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Bash Operating System Script; CLI control."
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
{ #{{{  ----- Activate:  initialization and termination
  #
		echo "$(date +%a_%m%d%y_%T) Initializing boss.sh... " >&3 
	# Create necessary files and directories:
[ ! -d $dir_var ] && mkdir -p $dir_var
[ ! -d $dir_lib ] && mkdir -p $dir_lib
[ ! -d $dir_conf ] && mkdir -p $dir_conf 
#
# Run application
App_MAIN
# Exit program
echo "$(date +%a_%m%d%y_%T) Exiting." >&3 
exit

} #}}}
App_CONF()
{ #{{{  ----- App_CONF
	d=$dir_conf && [ ! -d $d ] && mkdir -p $d
	f= && [ ! -d $d ] && mkdir -p $d

} #}}}
App_MAIN()
{ #{{{  ----- App_MAIN:  open main application
  #
	Exec_USERselect
	Exec_ACTS

} #}}}
Exec_USERselect()
{ #{{{  ----- Exec_USERselect
	d=$lib/user && [ ! -d $d ] && mkdir -p $d 
	cd $d && [ ! -d .New_user ] && mkdir .New_user
	echo "Welcome to boss, where you control the commands."
	echo "Let's get you logged in!" && sleep 2
	echo -e "\n    Users:"
	if [[ $(ls $d) == "" ]] ; then 
		Exec_USERcreate
	else
		PS3="   Press the appropriate number, then hit enter:  "
		select u in $(ls -A) ; do
			if [[ $u  == ".New_user" ]] ; then
				Exec_USERcreate
			fi
			break
		done 2>&1
	fi 

} #}}}
Exec_USERcreate()
{ #{{{  ----- Exec_USERcreate
		echo "What's your name?" 
		read u && d=$u && mkdir $d
		. $dir/
		. $f

} #}}}
Exec_ACTS()
{ #{{{  ----- Exec_ACTS
	d=$u && cd $d
	if [[ $(ls) == "" ]] ; then
		touch "1 2 3"
	else
		echo
	fi

} #}}}
   ###  PROGRAM EXECUTION
Activate

#Exit program:

  #
	###  ISSUES AND BUGS
	###  NOTES
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
	 #
#### Code clippings
	 #
  #
 #
#

#while :; do #This while loop is always open.
#	sleep 60
#	echo "" | $tee -a $file_log_0
#done
