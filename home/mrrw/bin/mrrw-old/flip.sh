###
#!/bin/sh
set +v; set +x; set -e; set +u
# set -u       # set program to exit if no positional parameters provided by user.
# ~/bin/flip.sh
# by Michael Milk (mrrw.github)
#
# See App_PREP() for program variables, sources, and directories.
# See end of file for known issues and bugs.
#
 #
  #
   #
   ###  HELP AND OPTIONS
   #
Help()
{
	#Display Help.
	echo "USAGE:  flip [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Choose between two or more subjects."
	echo
	echo "OPTIONS:"
	echo "-h	Display this help and exit."
	echo "-l	Display log and exit."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
   # Get the options:
#{{{
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
   #
   ###  PROGRAM COMMANDS
   #
App_ACTIVATE()
{ #{{{  ----- App_ACTIVATE:  Initialization and termination
  #
  ###  LOGS - required before initialization
  #
file_log_0=$HOME/var/log/flip_0.log && fl0=$file_log_0
file_log_1=$HOME/var/log/flip_1.log && fl1=$file_log_1
file_log_2=$HOME/var/log/flip_2.log && fl2=$file_log_2
  # curate logs:
[ -s $fl1 ] && mv $fl1 $fl2
[ -s $fl0 ] && mv $fl0 $fl1
  # open main log:
exec 3<> $fl0                    # Open log under file descriptor 3
  # set stdout and stderr direction:
exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> /dev/pts/4              # Open tty 4 for sending user messages, fd 4
#exec 1>&4                        # OPTIONAL:  Send all stdout to tty 4
  #
  ###  INITIALIZE
  #
s="Initializing flip.sh..." && App_LOG #&& App_ECHO
  #
App_PREP      # Create necessary files and directories, set daemon status
  #
  # Start main application:
if [ $daemon = "y" ] ; then
	App_START&  # adding & at the end of a command runs it in the background.
	s="Starting flip as daemon; exiting to terminal." && App_ECHO && App_LOG
else
	App_START   # Program will run in termimal until complete.
	s="Exiting flip.sh." && App_LOG #&& App_ECHO
fi
exit

} #}}}
App_ECHO()
{ #{{{  ----- App_ECHO:  display string in terminal
  #
  echo -e "$s"
  #

} #}}}
App_LOG()
{ #{{{  ----- App_LOG:  add string to log
  #
  echo -e "$(date +%a_%m%d%y_%T) $s " >&3 
  #

} #}}}
App_PREP()
{ #{{{  ----- App_PREP:  Assign initial values and create necessary directories
  #
  s="Preparing to execute..." && App_LOG
  #
  ###  SOURCES
  #
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
  #
  ###  DIRECTORIES AND  FILES
  #
  # Address file structure for all mrrw scripts:
#[ ! -d $HOME/var ] && mkdir 
  # Standardized variables for files and directories:
dir_conf=$HOME/.config/flip
dir_home=$HOME/flip
dir_lib=$HOME/lib/flip && lib=$dir_lib
dir_log=$HOME/var/log
dir_var=$HOME/var/flip && var=$dir_var
file_conf_0=$HOME/.config/flip/flip.conf
file_log_0=$HOME/var/log/flip.log
  # Create required files and directories:
  s="Looking for missing directories..." && App_LOG
#[ ! -d $dir_conf ] && mkdir -p $dir_conf  && s="Creating $dir_conf." && App_LOG
#[ ! -d $dir_home ] && mkdir -p $dir_home  && s="Creating $dir_home." && App_LOG
#[ ! -d $dir_lib ] && mkdir -p $dir_lib  && s="Creating $dir_lib." && App_LOG
#[ ! -d $dir_log ] && mkdir -p $dir_log  && s="Creating $dir_log." && App_LOG
#[ ! -d $dir_var ] && mkdir -p $dir_var  && s="Creating $dir_var." && App_LOG
#
  #
  ###  PROGRAM VARIABLES
  #
daemon=n      # A daemon is an application that runs in the background. 
              # This frees up the terminal for further use,
              # but makes it harder for the user to terminate the program.

} #}}}
App_START()
{ #{{{  ----- App_START:  open main application 
  #
  s="Executing main application." && App_LOG
  #
  # Executing program main commands:
  Exec_FLIP

} #}}}
Exec_FLIP()
{ #{{{  ----- Exec_FLIP:  execute command
  #
  s="Executing main command." && App_LOG
  #
  # Main command:
  s="Echoed \"hello world\"."
	echo -e "Enter a letter for each subject you want to randomize between."
	read r
	n=$(echo -n $r | wc -m)
	echo "Order after randomization:"
for x in $(shuf -i 1-$n) ; do
	if [[ $n != 1 ]] ; then
		echo "    $(echo $r | head -c $x | tail -c 1),"
	else
		echo "and $(echo $r | head -c $x | tail -c 1)."
	fi
	n=$(expr $n - 1)
	sleep 1
done

} #}}}
   #
   ###  PROGRAM EXECUTION
   #
App_ACTIVATE

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
#### Code clippings
   #
  #
 #
#

#while :; do #This while loop is always open.
#	sleep 60 # pause for 60 seconds before acting.  
#	echo "" | $tee -a $file_log_0
#done
#
Exec_ARMmain()
{ #{{{  ----- Exec_ARMmain:  execute command
  #
  s="Executing command ARMmain." && App_LOG
  #
  # Prep 
	cd $dir_downloads && ls | grep -i .zip > $tmp && s="Creating $tmp." && App_LOG
	r=n
	clear && ls | grep -i .zip 
	# Main
	while [ -s $tmp ] ; do
		Exec_ARMvars
		echo ""
		echo "Would you like to create $dir_arm?"
		echo -e "\t\t{n=no, y=yes, Y=yes-all}"
		read r
		if [[ $r == "Y" ]] ; then
			while [ -s $tmp ] ; do
				Exec_ARMvars
				Exec_FIRE
			done
		elif [[ $r == "y" ]] ; then
			Exec_ARMvars
			Exec_FIRE
		else
			sed -i '1d' $tmp
		fi
	done

} #}}}
Exec_ARMvars()
{ #{{{  ----- Exec_ARMvars:  execute command
	#
	# Prep
	s=$(head -n 1 $tmp)
	sA=$(echo $s | awk -F- '{ print $1 }' | sed 's/\ //')
	sB=$(echo $s | awk -F- '{ st = index($0,"-");print substr($0,st+1)}' | sed 's/.zip// ; s/\ //g ; s/\ /_/g')
	#
	# Main
	dir_arm=$dir/$sA/$sB/
	fZipFrom=$dir_downloads/$s
	fZipTo=$dir_arm/$s

} #}}}
Exec_FIRE()
{ #{{{  ----- Exec_FIRE:  execute command
  #
  s="Unzipping $fZip in $dir_arm." && App_ECHO && App_LOG
  #
  # main 
	cd "$dir_music"
	mkdir -p "$dir_arm"
	mv "$fZipFrom" "$dir_arm"
	cd "$dir_arm"
	unzip -q "$fZipTo"&
	sed -i '1d' $tmp

} #}}}
   #
   ###  PROGRAM EXECUTION
   #
App_ACTIVATE
