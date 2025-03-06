###
#!/bin/sh
set +v; set +x; set -e; set +u
# set -u       # set program to exit if no positional parameters provided by user.
# ~/bin/taboret.sh
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
	echo "USAGE:  taboret [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Display info and process custom commands using tmux."
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
while getopts ":hlvx" option; do
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
file_log_0=$HOME/var/log/taboret_0.log && fl0=$file_log_0 && log=$fl0
file_log_1=$HOME/var/log/taboret_1.log && fl1=$file_log_1
file_log_2=$HOME/var/log/taboret_2.log && fl2=$file_log_2
  # curate logs:
[ -s $fl1 ] && mv $fl1 $fl2
[ -s $fl0 ] && mv $fl0 $fl1
  # open main log:
exec 3<> $fl0                    # Open log under file descriptor 3
  # set stdout and stderr direction:
exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> /dev/pts/3              # Open tty 4 for sending user messages, fd 4
#exec 5<> $tmuxpane_songstatus              # Open tty 3 for displaying song progress
exec 1>&4                        # OPTIONAL:  Send all stdout to tty 4
exec 2>&4                        # OPTIONAL:  Send all stdout to tty 4
  #
  ###  INITIALIZE
  #
s="Initializing taboret.sh..." && App_LOG #&& App_ECHO
  #
App_PREP      # Create necessary files and directories, set daemon status
  #
  # Start main application:
if [ $daemon = "y" ] ; then
	App_START&  # adding & at the end of a command runs it in the background.
	s="Starting taboret as daemon; exiting to terminal." && App_ECHO && App_LOG
else
	App_START   # Program will run in termimal until complete.
	s="Exiting taboret.sh." && App_LOG #&& App_ECHO
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
dir_conf=$HOME/.config/taboret
dir_home=$HOME/taboret
dir_lib=$HOME/lib/taboret && lib=$dir_lib
dir_log=$HOME/var/log
dir_var=$HOME/var/taboret && var=$dir_var
file_conf_0=$HOME/.config/taboret/taboret.conf
file_log_0=$HOME/var/log/taboret.log
  # Create required files and directories:
  s="Looking for missing directories..." && App_LOG
[ ! -d $dir_conf ] && mkdir -p $dir_conf  && s="Creating $dir_conf." && App_LOG
#[ ! -d $dir_home ] && mkdir -p $dir_home  && s="Creating $dir_home." && App_LOG
[ ! -d $dir_lib ] && mkdir -p $dir_lib  && s="Creating $dir_lib." && App_LOG
#[ ! -d $dir_log ] && mkdir -p $dir_log  && s="Creating $dir_log." && App_LOG
[ ! -d $dir_var ] && mkdir -p $dir_var  && s="Creating $dir_var." && App_LOG
#
  #
  ###  PROGRAM VARIABLES
  #
daemon=y      # A daemon is an application that runs in the background. 
              # This frees up the terminal for further use,
              # but makes it harder for the user to terminate the program.
fT=$dir_var/tasklist.txt
tmuxpane_messages=$(tmux list-panes -a -F '#{pane_tty}' | awk '{ print $0 }' | head -n 2 | tail -n 1)
#	tmuxpane_songstatus=$(tmux list-panes -a -F '#{pane_tty}' | awk '{ print $0 }' | head -n 3 | tail -n 1)

} #}}}
App_START()
{ #{{{  ----- App_START:  open main application 
  #
  s="Executing main application." && App_LOG
  #
  # Executing program main commands:
	Exec_GREET
	Exec_HOME

} #}}}
Exec_GREET()
{ #{{{  ----- Exec_GREET
#
f=$dir_conf/greet.conf
if [ -s $f ] ; then
	. $f
else
	echo '#!/bin/bash' > $f
	echo '#' >> $f
	echo 'd=$dir_lib/images' >> $f
	echo 's1="\n\nGreetings from the taboret."' >> $f
	echo 's2="\nToday is $(date +%A,\ %B\ %d,\ %Y).\n\n"' >> $f
	[ ! -d $d ] && cd $dir_lib && mkdir images
fi
cd $d
	x=$(seq 7|tail -n 2|shuf|head -n 1)	
	while [[ $x != 1 ]] ; do
		f=$(ls $d|shuf|head -n 1)
		echo "$d/$f" >&3
		jp2a -f --color --size=65x65 $d/$f
		x=$(expr $x - 1)
		sleep 0.05
	done
	clear
			cmatrix="cmatrix -obcr -ur .$(seq 9|tail -n 4|shuf|head -n 1)"
			$cmatrix&
			sleep .$(seq 4|tail -n 4|shuf|head -n 1) && kill $!
			f=$(ls $d|shuf|head -n 1)
			jp2a -f --color --invert --size=65x65 $d/$f |shuf| head -n 9
	echo -e $s1 
	echo -e $s2 
			jp2a -f --flipy --color --invert --size=65x65 $d/$f|shuf | head -n 5
			sleep 5
			clear
			$cmatrix&
			sleep .$(seq 4|tail -n 4|shuf|head -n 1) && kill $!

} #}}}
Exec_HOME()
{ #{{{  ----- Exec_HOME
f=$dir_conf/home.conf
if [ -s $f ] ; then
	. $f
else
	echo '#!/bin/bash' > $f
	echo 'Exec_HOME=Exe_Neofetch' >> $f
	echo 'sleeptimer=$(seq 4|tail -n 2|shuf|head -n 1)$(seq 9|tail -n 1|shuf|head -n 1)' >> $f
fi
clear && $Exec_HOME
sleep $sleeptimer
	Exec_JUNC

} #}}}
Exec_JUNC()
{ #{{{ ----- Exec_JUNC
# (create and) source .conf:
f=$dir_conf/junc.conf
if [ -s $f ] ; then
	. $f
else
	echo '#!/bin/bash' > $f
	echo 'n=$(seq 1 | shuf | head -n 1)' >> $f
	echo 'Exec_TRANS="Exec_TRANS_$n"' >> $f
fi
# Transition:
	echo "$Exec_TRANS" >&3
	clear && $Exec_TRANS
	touch $fT
	t=$(head -n 1 $fT)
	[[ $t != "" ]] && $t
	Exec_HOME

	# Transition:
} #}}}
Exec_Neofetch()
{ #{{{  ----- Exhibit
#while [[ $x != 0 ]] ; do 
	l=$(grep -2 "pacman -Syu" /var/log/pacman.log | tail -1 | sed "s~T.*~~" | sed "s/^\[//") 
	s="butts"
	u=$(expr $(date +%j) - $y + 1) 
	y=$(date -d $l +%j) 
	neofetch="neofetch --disable theme icons memory packages wm de term uptime"
	colorize="lolcat -F .03 -p 6"
	clear 
	$neofetch|$colorize
	if [[ $radio == "y" ]] ; then
		echo -en $s
	else
		echo -n "Last system update:  $u days ago." 
	fi
	#sleep 600
#done

} #}}}
Exec_RadioConsole()
{ #{{{  ----- Exhibit
#while [[ $x != 0 ]] ; do 
	l=$(grep -2 "pacman -Syu" /var/log/pacman.log | tail -1 | sed "s~T.*~~" | sed "s/^\[//") 
	y=$(date -d $l +%j) 
	u=$(expr $(date +%j) - $y + 1) 
	neofetch="neofetch --disable theme icons memory packages wm de term uptime"
	echo="Last system update:  $u days ago."
	colorize="lolcat -F .03 -p 6"
if [[ $radio == "y" ]] ; then
	message="$radio_data"
fi
if [[ $radio_data != "" ]] ; then
	message="$radio_data"
clear 
echo $echo|$colorize
fi
	
	#sleep 600
#done

} #}}}
Exec_TRANS_0()
{ #{{{  ----- Exec_TRANS_0
	n=$(ls $dir_lib | grep trans | wc -l)
	if [[ $n != 0 ]] ; then
		trans=$(seq $n | shuf)
		f=$dir_lib/trans_$trans.bash
	else
		echo#placeholder
	fi

	d=$dir_lib/images
	[ ! -d $d ] && cd $dir_lib && mkdir images
	cd $d
	x=$(seq 7|tail -n 2|shuf|head -n 1)	
	while [[ $x != 1 ]] ; do
		f=$(ls $d|shuf|head -n 1)
		echo "$d/$f" >&3
		jp2a -f --color --size=65x65 $d/$f
		x=$(expr $x - 1)
		sleep 0.05
	done

} #}}}
Exec_TRANS_1()
{ #{{{  ----- Exec_TRANS_1
#  f=$dir_conf/trans.conf
if [ -s $f ] ; then
	. $f
else
	echo '#!/bin/bash' > $f
	echo 'n=$(seq 1 | shuf | head -n 1)' >> $f
	echo 'Exec_TRANS="Exec_TRANS_$n"' >> $f
fi
	cmatrix="cmatrix -obcr -ur .$(seq 9|tail -n 4|shuf|head -n 1)"
	f=$(ls $d|shuf|head -n 1)
		jp2a -f --color --size=65x65 $d/$f
		sleep .1
	f=$(ls $d|shuf|head -n 1)
		jp2a -f --color --invert --size=65x65 $d/$f
		sleep .1
	if [ $m = "" ] ; then
			$cmatrix&
			sleep .$(seq 8|tail -n 4|shuf|head -n 1) && kill $!
		else
			$cmatrix&
			sleep .$(seq 4|tail -n 4|shuf|head -n 1) && kill $!
			f=$(ls $d|shuf|head -n 1)
			jp2a -f --color --invert --size=65x65 $d/$f |shuf| head -n 9
			echo -e "\n\n$m\n\n"
			jp2a -f --flipy --color --invert --size=65x65 $d/$f|shuf | head -n 5
			sleep 5
			clear
			$cmatrix&
			sleep .$(seq 4|tail -n 4|shuf|head -n 1) && kill $!
	fi
	f=$(ls $d|shuf|head -n 1)
		jp2a -f --color --invert --size=65x65 $d/$f
	f=$(ls $d|shuf|head -n 1)
		jp2a -f --color --size=65x65 $d/$f | shuf

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

