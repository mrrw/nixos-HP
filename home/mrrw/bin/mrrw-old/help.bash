###
#!/bin/bash
set +v; set +x; set -e; set +u
# set -u       # set program to exit if no positional parameters provided by user.
# ~/bin/help.sh
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
	echo "USAGE:  help [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Print useful information to assist user with basic tasks."
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
App_RUN()
{ #{{{  ----- App_RUN:  Initialization and termination
  SetLogs()
  { #{{{
    file_log_0=$HOME/var/log/help_0.log && fl0=$file_log_0
    file_log_1=$HOME/var/log/help_1.log && fl1=$file_log_1
    file_log_2=$HOME/var/log/help_2.log && fl2=$file_log_2
  # curate logs:
    [ -s $fl1 ] && mv $fl1 $fl2
    [ -s $fl0 ] && mv $fl0 $fl1
  # open main log:
    exec 3<> $fl0                    # Open log under file descriptor 3
s="Initializing help.sh..." && App_LOG #&& App_ECHO
  } #}}}
  SetOutput()
  { #{{{
    #exec 2>&3                        # Redirect stderr to $file_log_0
    #exec 4<> /dev/pts/4              # Open tty 4 for sending user messages, fd 4
    #exec 1>&4                        # Send all stdout to tty 4
		echo > /dev/null
  } #}}}
  Sourcing()
  { #{{{
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
		echo > /dev/null
  } #}}}
  Directories()
  { #{{{
  # Standardized variables for files and directories:
dir_conf=$HOME/.config/help
dir_home=$HOME/help
dir_lib=$HOME/lib/help && lib=$dir_lib
dir_lib_hash=$lib/hash && lib_hash=$dir_lib_hash
dir_log=$HOME/var/log/help
dir_var=$HOME/var/help && var=$dir_var
dir_var_hash=$var/hash && var_hash=$dir_var_hash
file_conf_0=$HOME/.config/help/help.conf
file_log_0=$HOME/var/log/help.log
  # 
  s="Looking for missing directories..." && App_LOG
#[ ! -d $dir_conf ] && mkdir -p $dir_conf  && s="Creating $dir_conf." && App_LOG
#[ ! -d $dir_home ] && mkdir -p $dir_home  && s="Creating $dir_home." && App_LOG
#[ ! -d $dir_lib ] && mkdir -p $dir_lib  && s="Creating $dir_lib." && App_LOG
#[ ! -d $dir_log ] && mkdir -p $dir_log  && s="Creating $dir_log." && App_LOG
#[ ! -d $dir_var ] && mkdir -p $dir_var  && s="Creating $dir_var." && App_LOG
#
  } #}}}
  Run()
  {
    daemon=n      # A daemon is an application that runs in the background. 
                  # This frees up the terminal for further use, while
                  # making it harder for the user to terminate the program.
    if [ $daemon = "y" ] ; then
       s="Starting help as daemon; exiting to terminal." && App_ECHO && App_LOG
      Exec_help&  # adding & at the end of a command runs it in the background.
    else
       s="Executing help main program." && App_LOG #&& App_ECHO
      Exec_help   # Program will run in termimal until complete.
       s="Exiting help.bash." && App_LOG #&& App_ECHO
    fi
  }
SetLogs && SetOutput && Sourcing && Directories
Run && exit

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
Exec_help()
{ #{{{  ----- Exec_help:  execute main command
  #
  s="Initiation complete.  Executing program." && App_LOG
  #
	# How can I help you?
	# ls pwd cd mk mkdir rm mv date feh man sox 
	echo "How can I help you?"
	read r
	#echo "$r" >> "~/usr/helpRequest_$(date +%y%j%H%M).txt"
	echo "$r --$USER" >> ~/usr/helpRequest_$(date +%y%j%H%M).txt

} #}}}
   #
   ###  PROGRAM EXECUTION
   #
App_RUN

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
App_RUN
