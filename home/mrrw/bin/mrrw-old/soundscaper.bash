###
#!/bin/sh
set +v; set +x; set -e; set +u
# set -u       # set program to exit if no positional parameters provided by user.
# ~/bin/soundscaper.sh
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
	echo "USAGE:  soundscaper [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Create random soundscapes."
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
    file_log_0=$HOME/var/log/soundscaper_0.log && fl0=$file_log_0
    file_log_1=$HOME/var/log/soundscaper_1.log && fl1=$file_log_1
    file_log_2=$HOME/var/log/soundscaper_2.log && fl2=$file_log_2
  # curate logs:
    [ -s $fl1 ] && mv $fl1 $fl2
    [ -s $fl0 ] && mv $fl0 $fl1
  # open main log:
    exec 3<> $fl0                    # Open log under file descriptor 3
s="Initializing soundscaper.sh..." && App_LOG #&& App_ECHO
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
dir_conf=$HOME/.config/soundscaper
dir_home=$HOME/soundscaper
dir_lib=$HOME/lib/soundscaper && lib=$dir_lib
dir_lib_hash=$lib/hash && lib_hash=$dir_lib_hash
dir_log=$HOME/var/log/soundscaper
dir_var=$HOME/var/soundscaper && var=$dir_var
dir_var_hash=$var/hash && var_hash=$dir_var_hash
file_conf_0=$HOME/.config/soundscaper/soundscaper.conf
file_log_0=$HOME/var/log/soundscaper.log
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
       s="Starting soundscaper as daemon; exiting to terminal." && App_ECHO && App_LOG
      Exec_soundscaper&  # adding & at the end of a command runs it in the background.
    else
       s="Executing soundscaper main program." && App_LOG #&& App_ECHO
      Exec_soundscaper   # Program will run in termimal until complete.
       s="Exiting soundscaper.bash." && App_LOG #&& App_ECHO
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
Exec_soundscaper()
{ #{{{  ----- Exec_soundscaper:  execute main command
  #
  s="Executing main command." && App_LOG
  #
  # Main command:
	MakeSounds()
	{ #{{{
while true ; do
	rec -c 2 tmp.wav trim 0 0:07
	play tmp.wav lowpass -1 200k reverse 
	rec -c 2 tmp2.wav trim 0 0:07
	play tmp2.wav reverse &
done &
pid_mimic=$!
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 3.7 13.8 3.7 tremolo 50 100 reverb flanger ;  done &
while true  ;  do play -n -c1 synth tri %-$(seq 12 24 | shuf | head -1) fade h 3.7 13.8 3.7 tremolo 50 100 reverb flanger ;  done &

	} #}}}
MakeSounds

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

play -n -c1 synth sin %-6 fade h 0.5 10 0.5 ; ; 
play -n -c1 synth sin %-6 fade h 0.5 2 0.5 ; ; 
play -n -c1 synth sin %-6 fade h 0.7 2 0.7 ; ; 
play -n -c1 synth sin %-6 fade h 0.7 1.5 0.7 ; ; 
play -n -c1 synth sin %-6 fade h 0.7 1.8 0.7 ; ; 
play -n -c1 synth saw %-6 fade h 0.7 1.8 0.7 ; ; 
play -n -c1 synth tri %-6 fade h 0.7 1.8 0.7 trem ; ; 
play -n -c1 synth tri %-6 fade h 0.7 1.8 0.7 ; ; 
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 ;  done
q ; ; 
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 ;  done
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 ;  done
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 ;  done
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 0.7 3.8 0.7 tremolo;  done
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 0.7 3.8 0.7 tremolo ;  done
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 0.7 3.8 0.7 tremolo 30 30 ;  done
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 0.7 3.8 0.7 tremolo 100 1000 ;  done
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 0.7 3.8 0.7 tremolo 100 100 ;  done
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 0.7 3.8 0.7 tremolo 50 100 ;  done
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 3.7 13.8 3.7 tremolo 50 100 delay;  done
while true  ;  do play -n -c1 synth g1 %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 ;  done
while true  ;  do play -n -c1 synth G2 %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 ;  done
while true  ;  do play -n -c1 synth pl G2 pl %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 ;  done
while true  ;  do play -n -c1 synth pl G2 pl %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 delay;  done
while true  ;  do play -n -c1 synth pl G2 pl %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 delay 0 .05 .1 .15 .2 .25 ;  done
while true  ;  do play -n -c1 synth pl G2 pl %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 delay 0 .05 ;  done
while true  ;  do play -n -c1 synth pl G2 pl %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 delay 0 .05 .1 .25 ;  done
while true  ;  do play -n -c1 synth pl G2 pl %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 delay 0 .05 .1 ;  done
while true  ;  do play -n -c1 synth pl G2 pl %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 lowpass;  done
while true  ;  do play -n -c1 synth pl G2 pl %-$(seq 12 | shuf | head -1) fade h 0.7 1.8 0.7 lowpass -1 -2;  done
rec -c tmp.wav trim 0 0:10 ; ; 
rec -c 2 tmp.wav trim 0 0:10 ; ; 
play tmp.wav ; ; 
play tmp.wav fade .1 7 .1 ; ; 
play tmp.wav fade .1 7 .3 ; ; 
play tmp.wav fade .1 7 .6 ; ; 
play tmp.wav fade .1 7 6 ; ; 
play tmp.wav fade .1 7 2 ; ; 
play tmp.wav fade 2 7 2 ; ; 
while true  ;  do rec -c 2 tmp.wav trim 0 0:10 && play tmp.wav fade 3 7 2 reverse ;  done
while true  ;  do rec -c 2 tmp2.wav trim 0 0:10 && play tmp2.wav fade 3 7 2 reverse ;  done
while true  ;  do play -n -c1 synth tri %-$(seq 12 | shuf | head -1) fade h 3.7 13.8 3.7 tremolo 50 100 reverb flanger ;  done
