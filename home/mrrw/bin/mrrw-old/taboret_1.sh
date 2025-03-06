###
#!/bin/sh
set +v; set +x; set -e; set +u
# set -u       # set program to exit if no positional parameters provided by user.
# ~/bin/taboret.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
   #
   ###  SOURCES
	 #
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
	 #
   ###  FILES AND DIRECTORIES
	 #
dir_conf=$HOME/.config/taboret && conf=$dir_conf
dir_lib=$HOME/lib/taboret && lib=$dir_lib
dir_var=$HOME/var/taboret && var=$dir_var
fT=$dir_var/tasklist.txt
	 #
   ###  VARIABLES
	 #
tmuxpane_messages=$(tmux list-panes -a -F '#{pane_tty}' | awk '{ print $0 }' | head -n 2 | tail -n 1)
#	tmuxpane_songstatus=$(tmux list-panes -a -F '#{pane_tty}' | awk '{ print $0 }' | head -n 3 | tail -n 1)
   #
   ###  LOGS
	 #
file_log_0=$HOME/var/log/taboret_0.log && fl0=$file_log_0
file_log_1=$HOME/var/log/taboret_1.log && fl1=$file_log_1
file_log_2=$HOME/var/log/taboret_2.log && fl2=$file_log_2
   # curate logs:
[ -s $fl1 ] && mv $fl1 $fl2
[ -s $fl0 ] && mv $fl0 $fl1
   # open main log:
exec 3<> $fl0                    # Open log under file descriptor 3
   # redirection:
#exec 1>&3                        # Redirect stderr to $file_log_0
#exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> $tmuxpane_messages              # Open tty 4 for sending user messages, fd 4
exec 1>&4                        # Send all stdout to tty 4
exec 2>&4                        # Send all stdout to tty 4
#exec 5<> $tmuxpane_songstatus              # Open tty 3 for displaying song progress
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
	 #
   ###  PROGRAM COMMANDS
	 #
Activate()
{ #{{{  ----- Activate
	echo "Initializing taboret."
	echo "$(date +%a_%m%d%y_%T) Initializing taboret... " >&3 
	# Create files and directories:
[ ! -d $dir_var ] && mkdir -p $dir_var
[ ! -d $dir_lib ] && mkdir -p $dir_lib
[ ! -d $dir_conf ] && mkdir -p $dir_conf 
App_BEGIN&
echo "$(date +%a_%m%d%y_%T) Starting daemon; exiting to terminal, if applicable." >&3 
exit

} #}}}
App_ADD_conf()
{ #{{{  ----- App_ADD_conf
	echo -e "" > app.conf
	echo -e "" > exe.conf
	echo -e "" > commands.conf

} #}}}
App_BEGIN()
{ #{{{  ----- App_BEGIN
clear
	App_GREET
	App_HOME

} #}}}
App_GREET()
{ #{{{  ----- App_GREET
#
f=$dir_conf/greet.conf
if [ -s $f ] ; then
	. $f
else
	echo '#!/bin/bash' > $f
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
App_HOME()
{ #{{{  ----- App_HOME
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
	App_JUNC

} #}}}
App_JUNC()
{ #{{{ ----- App_JUNC
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
	App_HOME

	# Transition:
} #}}}
Exec_Neofetch()
{ #{{{  ----- Exhibit
#while [[ $x != 0 ]] ; do 
	l=$(grep -2 "pacman -Syu" /var/log/pacman.log | tail -1 | sed "s~T.*~~" | sed "s/^\[//") 
	y=$(date -d $l +%j) 
	u=$(expr $(date +%j) - $y + 1) 
	neofetch="neofetch --disable theme icons memory packages wm de term uptime"
	colorize="lolcat -F .03 -p 6"
	clear 
	$neofetch|$colorize
	echo -n "Last system update:  $u days ago." 
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
	clear 
	echo $echo|$colorize
	
	#sleep 600
#done

} #}}}
Exec_TRANS_0()
{ #{{{  ----- Exec_TRANS_0
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
f=$dir_conf/trans.conf
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
m="hello world..."
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

#while :; do #This while loop is always open.
#	sleep 60
#	echo "" | $tee -a $file_log_0
#done
Action_ARM()
{ #{{{  ----- Action_ARM
	PS3="   ...select an action from the above list."
	clear
  echo -e "\n\n"

	action="dance dance revolution"
	select a in ${action[@]} ; do
		echo $a
		break
	done 


} #}}}
Action_COMMIT()
{ #{{{  ----- Action_ARM
	echo

} #}}}
