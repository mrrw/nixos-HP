###
#!/bin/shoes.sh
set +v; set +x; set -e; set +u
# set -u       # set program to exit if no positional parameters provided by user.
# ~/bin/shoes.sh
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
	echo "USAGE:  shoes [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Sound Handler for Optimum Efficiency & Simplicity."
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
file_log_0=$HOME/var/log/shoes_0.log && fl0=$file_log_0
file_log_1=$HOME/var/log/shoes_1.log && fl1=$file_log_1
file_log_2=$HOME/var/log/shoes_2.log && fl2=$file_log_2
  # curate logs:
[ -s $fl1 ] && mv $fl1 $fl2
[ -s $fl0 ] && mv $fl0 $fl1
  # open main log:
exec 3<> $fl0                    # Open log under file descriptor 3
  # set stdout and stderr direction:
#exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> /dev/pts/4              # Open tty 4 for sending user messages, fd 4
#exec 1>&4                        # OPTIONAL:  Send all stdout to tty 4
  #
  ###  INITIALIZE
  #
s="Initializing shoes.sh..." && App_LOG #&& App_ECHO
  #
App_PREP      # Create necessary files and directories, set daemon status
  #
  # Start main application:
if [ $daemon = "y" ] ; then
	App_START&  # adding & at the end of a command runs it in the background.
	s="Starting shoes as daemon; exiting to terminal." && App_ECHO && App_LOG
else
	App_START   # Program will run in termimal until complete.
	s="Exiting shoes.sh." && App_LOG #&& App_ECHO
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
dir_conf=$HOME/.config/shoes
dir_home=$HOME/shoes
dir_lib=$HOME/lib/shoes && lib=$dir_lib
dir_log=$HOME/var/log
dir_var=$HOME/var/shoes && var=$dir_var
file_conf_0=$HOME/.config/shoes/shoes.conf
file_log_0=$HOME/var/log/shoes.log
  # Create required files and directories:
  s="Looking for missing directories..." && App_LOG
#[ ! -d $dir_conf ] && mkdir -p $dir_conf  && s="Creating $dir_conf." && App_LOG
#[ ! -d $dir_home ] && mkdir -p $dir_home  && s="Creating $dir_home." && App_LOG
#[ ! -d $dir_lib ] && mkdir -p $dir_lib  && s="Creating $dir_lib." && App_LOG
#[ ! -d $dir_log ] && mkdir -p $dir_log  && s="Creating $dir_log." && App_LOG
[ ! -d $dir_var ] && mkdir -p $dir_var  && s="Creating $dir_var." && App_LOG
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
	clear
	echo ""
	echo "   Welcome to SHOES,"
	echo "      the Sound Handler for Optimum Efficiency and Simplicity."
	echo ""
	sleep 1
  MENU_choose

} #}}}
MENU_choose()
{ #{{{  MENU_choose
	#
  s="	Executing MENU_choose." && App_LOG
	while true ; do
choose_dir() {
	PS3="    Choose a directory:  "
	select dir in $(tree -nif | grep -iw wav | sed 's![^/]*$!!' | sort -u) ; do
		sleep .1 && echo
		break
	done }
choose_file() {
	PS3="    Choose a file to play with:  "  
	select f in $(ls -A $dir| grep -iw wav |  sort -u) ; do
		f=$dir$f
		sleep .1 && echo 
		MENU_action
		break
	done }
choose_dir && choose_file
done

} #}}}
MENU_action()
{ #{{{  MENU_action
	#
  s="		Executing MENU_action." && App_LOG
	#
	file_name=$(echo $f | awk -F. ' { print $1 } ') && fn=$file_name
	file_suffix=$(echo $f | awk -F. ' { print $1 } ') && fs=$file_suffix
	first_play=y  # turned to 'n' in Play()

	Delete()
	{ #{{{  Delete
		#
		s="Removing $f!" && App_LOG && App_ECHO
		rm $f

	} #}}}
	Highlight()
	{ #{{{  Highlight
		#
		s="Highlighting selection." && App_LOG && App_ECHO
		n2=$(tail -n 4 $var/tmp.txt |head -n 1|awk -F "A" '{print $NF}'|awk '{print $2}')
	if [[ $n2 == "" ]] ; then 
		n2=$(tail -n 3 $var/tmp.txt |head -n 1|awk -F "A" '{print $NF}'|awk '{print $2}')
	elif [[ $n2 == "playback..." ]] ; then 
		n2=$(tail -n 3 $var/tmp.txt |head -n 1|awk -F "A" '{print $NF}'|awk '{print $2}')
	elif ! [[ $n2 =~ ^[0-9] ]] ; then
		echo 'ERROR parsing $n2 (stop position).  Not a number, exiting to preserve file.'
		exit 1  # exit with error status
	fi
	echo '' && clear
	echo ''
		s="  echo $f  " && App_LOG && App_ECHO
		s="  Playback started at $n1.  " && App_LOG && App_ECHO
		s="  Playback stopped at $n2.  " && App_LOG && App_ECHO
	echo ''

	} #}}}
	Move() 
	{ #{{{  Move
		#
		PS3="   To where would you like to move this file?  "
	select dir in $(tree -nif | grep -iw wav | sed 's![^/]*$!!' | sort -u) ; do
		sleep 0.1 && echo
		s="			OK, moving $f to $dir." && App_LOG && App_ECHO
		mv $f $dir
		sleep 0.5 && echo
		break
	done 

		} #}}}
	Play() 
	{ #{{{  Play
		#
		s="			...playing $f..." && App_LOG && App_ECHO
		playask() {
			echo "  Please enter a start point, in seconds:  " 
			read n1 && if [[ $n1 = "" ]] ; then n1=0 ; fi
			echo "  OK, playing $f, starting at $n1." && sleep .5
		}
		if [[ $first_play == y ]] ; then
			n1=0
		else
			playask
		fi
		mplayer $f -ss $n1 | lolcat -F .006 | tee $var/tmp.txt 
		first_play=n

		} #}}}
	Question()
	{ #{{{  Question
		#
	s="			Asking Question" && App_LOG
	repeat=y

		Ask() {
	s="				Executing Ask" && App_LOG
	echo ''
	PS3="  What would you like to do?  "
	actions=("choose another file" "delete file" "move file" "play again" "trim, keeping selection")
	s="					...asking now..." && App_LOG
	select a in "${actions[@]}" ; do
	s="					...selection received..." && App_LOG
		case $a in
			"choose another file")
				repeat=n && break
				;;
			"delete file")
				s="						...deleting $f...?" && App_LOG
				echo "Are you sure you want to delete the file?  "
				read r2 && if [[ $r2 == "y" ]] ; then Delete && repeat=n; fi
				break ;;
			"move file")
				s="						...moving $f..." && App_LOG
				Move && repeat=n && break ;;
			"play again")
				s="						...playing $f..." && App_LOG
				Play && repeat=y && break ;;
			"trim, keeping selection")
				s="						...trimming $f..." && App_LOG
				Trim && repeat=y && break ;;
			"*")
				s="						...not an option, break..." && App_LOG
				repeat=n && break ;;
		esac
		break
	done
}
Play
Highlight
while [[ $repeat == "y" ]] ; do Ask ; done

	} #}}}
	Save()
	{ #{{{  Save
		#
		x1=$(ls -1Av | head -n 1 | awk -F "." '{print $2}')
		x2=$(pwd | awk -F "/" '{print $NF}')
		if [[ $x1 != $x2 ]] ; then
			d="$fs/"
			if [ ! -d $d ] ; then 
				echo ''
				s="Storing source and output files in $dir$d." && App_LOG && App_ECHO
				sleep .5
				mkdir $d
				mv $f $d/.$f
			fi
		fi

	} #}}}
	Trim() 
	{ #{{{  Trim
		#
	file_in=$f && fi=$file_in
		Highlight
		response=("Create New" "Overwrite")
		PS3="   Would you like to create a new file, or overwrite the original?  "
		select r in "${response[@]}" ; do
			s="					...selection received..." && App_LOG
			case $r in
				"Create New")
					file_out=$dir$(date +%H%M).wav && fo=$file_out
					s="Trimming $fi, creating $fo." && App_LOG && App_ECHO
					sox $(echo "$fi $fo trim $n1 $n2")
					sleep 1.5
					Save
					break
					;;
				"Overwrite")
					file_out=$var/tmp.wav && fo=$file_out
					s="Trimming $fi." && App_LOG && App_ECHO
					sox $(echo "$fi $fo trim $n1 $n2")
					rm $f
					mv $fo $f
					sleep 1.5
					break
					;;
			esac
		done


	} #}}}
	cd
Question
MENU_choose

	} #}}}
	#
	#
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
sed 's![^/]*$!!'
play() { mplayer $f }
record() { sox -d $f && rec=record }
