###
#!/bin/bash
set +v; set +x; set -e; set +u
# set -u       # set program to exit if no positional parameters provided by user.
# ~/bin/pl.bash
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
	echo "USAGE:  pl [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Create a datestamped personal log entry."
	echo
	echo "OPTIONS:"
	echo "-h	Display this help and exit."
	echo "-l	Display log and exit."
	echo "-U  Specify user, creating one if they don't exist."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
   # Get the options:
#{{{
while getopts ":hUvx" option; do
	case $option in
		h | --help) 
			Help; exit
			;;
		l | --log) 
			less $log; exit
			;;
		U | --user) 
			shift
			u="$@" 
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
    file_log_0=$HOME/var/log/pl_0.log && fl0=$file_log_0
    file_log_1=$HOME/var/log/pl_1.log && fl1=$file_log_1
    file_log_2=$HOME/var/log/pl_2.log && fl2=$file_log_2
  # curate logs:
    [ -s $fl1 ] && mv $fl1 $fl2
    [ -s $fl0 ] && mv $fl0 $fl1
  # open main log:
    exec 3<> $fl0                    # Open log under file descriptor 3
s="Initializing pl.sh..." && App_LOG #&& App_ECHO
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
dir_conf=$HOME/.config/pl
dir_home=$HOME/pl
dir_lib=$HOME/lib/pl && lib=$dir_lib
dir_lib_hash=$lib/hash && lib_hash=$dir_lib_hash
dir_log=$HOME/var/log/pl
dir_usr=$HOME/usr/$USER/pl
dir_var=$HOME/var/pl && var=$dir_var
dir_var_hash=$var/hash && var_hash=$dir_var_hash
file_conf_0=$HOME/.config/pl/pl.conf
file_log_0=$HOME/var/log/pl.log
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
       s="Starting pl as daemon; exiting to terminal." && App_ECHO && App_LOG
      Exec_pl&  # adding & at the end of a command runs it in the background.
    else
       s="Executing pl main program." && App_LOG #&& App_ECHO
      Exec_pl   # Program will run in termimal until complete.
       s="Exiting pl.bash." && App_LOG #&& App_ECHO
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
Exec_pl()
{ #{{{
	# set pl storage directory, if not already set
  s="Executing main command." && App_LOG
d=$dir_usr
if [ ! -d $d ] ; then mkdir -p $d ; fi
	# Make sure folding works:
set foldopen& #opens the fold that the cursur lands on.
	# Catagorize and name the document: 
		entrytypeOut="pl--"
		entrynameOut=`date +%F`
#NOTE: Placing $DOC in quotes allows for spaces in the title.
# Otherwise, .sh throws error 'ambiguous redirect.'
DOC=$d/$entrytypeOut$entrynameOut.txt
date +%c >> "$DOC"
echo -en "\n\n" >> "$DOC"
vim + -c startinsert "$DOC"
echo -en "\n**********\n" >> "$DOC"
echo "\"$DOC\" was modified:" && stat -c %y "$DOC"

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
   #
   ###  PROGRAM EXECUTION
   #
App_RUN


###############################################################################

   ###  PROGRAM COMMANDS
Activate()
{ #{{{
	echo "Initializing pl."
	echo "$(date +%a_%m%d%y_%T) Initializing pl... " >&3 
	# Create files and directories:
#[ ! -d $dir_var ] && mkdir -p $dir_var
#[ ! -d $dir_lib ] && mkdir -p $dir_lib
Exec_PL
	echo "Exiting pl."
	echo "$(date +%a_%m%d%y_%T) ...exiting pl." >&3 && exit

} #}}}
   ###  PROGRAM EXECUTION
Activate


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
   #
  #
 #
#
