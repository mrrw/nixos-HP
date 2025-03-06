###
#!/bin/sh
# ~/bin/radio.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
#
set +v; set +x; set -e; set +u
# set -u # exit if no positional parameters provided by user.
#
   ###  FILES AND DIRECTORIES
	 #
dir_conf=$HOME/.config/radio
dir_lib=$HOME/lib/radio
dir_music=$HOME/usr/Music                       # Variable used in RADIOqueue
dir_var=$HOME/var/radio
 f0=$dir_var/.tmp
 f1=$dir_var/playlist.spool
 f2=$dir_var/ignore.today
 f3=$dir_var/queue.spool
	 #
   ###  PROGRAM VARIABLES
	 #
espeak="espeak -s 120 -p 10 -v en-us+f5" #Default voice.
Format=""
radiotimer=25
signoffEcho=""
signoffEspeak=""
tmuxpane_messages=$(tmux list-panes -a -F '#{pane_tty}' | awk '{ print $0 }' | head -n 4 | tail -n 1)
tmuxpane_songstatus=$(tmux list-panes -a -F '#{pane_tty}' | awk '{ print $0 }' | head -n 3 | tail -n 1)
   #
   ###  LOGS
   #
file_log_0=$HOME/var/log/radio_0.log && fl0=$file_log_0
file_log_1=$HOME/var/log/radio_1.log && fl1=$file_log_1
file_log_2=$HOME/var/log/radio_2.log && fl2=$file_log_2
   # curate logs:
[ -s $fl1 ] && mv $fl1 $fl2
[ -s $fl0 ] && mv $fl0 $fl1
   # open main log:
exec 3<> $file_log_0             # Open log under file descriptor 3
   # redirection:
exec 2>&3                        # Redirect stderr to $file_log_0
exec 4<> $tmuxpane_messages      # Open tty 5 for sending user messages, fd 5
exec 1>&4                        # Send all stdout to tty 4
exec 5<> $tmuxpane_songstatus              # Open tty 3 for displaying song progress
   #
Help()
{
	#Display Help.
	echo "USAGE:  radio [--options]; [user input]; [user input]"
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
{ #{{{ ------- ACTIFY
	#
  echo "$(date +%a_%m%d%y_%T) Initializing radio..." >&3
	#
	# Create main directories and files
[ ! -d $dir_conf ] && mkdir -p $dir_conf
[ ! -d $dir_lib ] && mkdir -p $dir_lib
[ ! -d $dir_var ] && mkdir -p $dir_var
fF=$dir_conf/format.conf && if [ ! -s $fF ] ; then
	echo 'case $((' > $fF
	echo '	( 10#${d} >= 10#0700 && 10#${d} <= 10#0800) * 1 +' >> $fF
	echo '	( 10#${d} >= 10#0830 && 10#${d} <= 10#1130) * 2 +' >> $fF
	echo '	( 10#${d} >= 10#1130 && 10#${d} <= 10#1230) * 3 +' >> $fF
	echo '	( 10#${d} >= 10#1300 && 10#${d} <= 10#1800) * 4 +' >> $fF
	echo '	( 10#${d} >= 10#1800 && 10#${d} <= 10#2330) * 5 )) in' >> $fF
	echo '	(1) Format="morning" ;;' >> $fF
	echo '	(2) Format="study" ;;' >> $fF
	echo '	(3) Format="lunch" ;;' >> $fF
	echo '	(4) Format="evening" ;;' >> $fF
	echo '	(5) Format="goodnight" ;;' >> $fF
	echo '	(0) Format="" ;;' >> $fF
	echo 'esac' >> $fF
fi
	RADIOformat&
	exit

} #}}}
RADIOformat()
{ #{{{  ----- RADIOformat
	#
	# SEE BashCaseRadioFormat*.txt
[[ -a $f1 ]] && rm $f1                        # Reset playlist
	# Reset ignore list, if day old
ignoreDate=$(stat --format=%w $f2 | head -c 10 | tail -c 2)
[[ -a $f2 ]] && if [ "$(date +%d)" != "$ignoreDate" ] ; then rm $f2 ; fi
	# Find format based on current time
FormatOld=$Format && d="$(date +%H%M)"
. $fF                                         # source format.conf
if [ $Format = "" ] ; then RADIOsignoff ; else
	[[ $FormatOld != $Format ]] && [[ -s $f1 ]] && rm $f1
	if [[ -s $f1 ]]; then
		BLOCKcallsign
		BLOCKplay
	else
		RADIOqueue
		BLOCKcallsign
		BLOCKplay
	fi
fi

} #}}}
RADIOqueue()
{ #{{{ ----- RADIOqueue
fA="$dir_var/.artistlist.tmp"
fB="$dir_var/.queuesong.tmp"
fC="$dir_var/.playlist.tmp"
fD="$dir_var/.ignoretoday.tmp"
fE="$dir_var/.queueignore.tmp"
	cd $dir_music
		# Reset tmp files
	touch $fA $fB $fC $fD $fE
	rm $fA $fB $fE
	touch $fA $fB $fC $fD $fE
		# Ignore artists in $artistIGNOR array
	artistARRAY=($(ls -d */ | sed 's/\/// ; s/ //g')) 				# Critical step
	artistIGNOR=("ORL")
	for artist in ${artistARRAY[@]} ; do			 				# Critical step
		echo $artist >> $fA
	done
	for artist in ${artistIGNOR[@]} ; do
		echo $artist >> $fA
	done
	cat $fA |sort| uniq -iu > $fB && cat $fB |shuf > $fA
		# Create list and arm tracks, ignoring songs already played today
	while [[ $(sed -n '$=' $fA) != 1 ]] ; do
		s=$(head -n 1 $fA) && sed -i '1d' $fA ;
		tree -if $s | grep -i .mp3 |awk 'NF' > $fB ;
		cat $fB $fD |sort| uniq -d > $fE
		cat $fB $fE |sort| uniq -u | shuf | head -n 1 >> $fC
	done
	rm $fA $fB $fE

} #}}}
RADIOqueue_0()
{ #{{{ RADIOqueue
		# Ignore artists in $artistIGNOR array
	cd $dir_music
	artistARRAY=($(ls -d */ | sed 's/\/// ; s/ //g')) 				# Critical step
	artistIGNOR=("ORL")
	for artist in ${artistARRAY[@]} ; do							 				# Critical step
		echo $artist > $f0
	done
	for artist in ${artistIGNOR[@]} ; do
		echo $artist >> $f0
	done
	cat $f0 |sort| uniq -iu > $f1 && cat $f1 |shuf > $f0

fA="$dir_var/.artistlist.tmp"
fB="$dir_var/.queuesong.tmp"
fC="$dir_var/.playlist.tmp"
fD="$dir_var/.ignoretoday.tmp"
fE="$dir_var/.queueignore.tmp"
		# Reset tmp files
	touch $fA $fB $fC $fD $fE
	rm $fA $fB $fE
	touch $fA $fB $fC $fD $fE
		# Create list and arm tracks, ignoring songs already played today
	while [[ -s $fA ]] ; do
		s=$(head -n 1 $fA) && sed -i '1d' $fA ;
		tree -if $s | grep -i .mp3 |awk 'NF' > $fB ;
		cat $fB $fD |sort| uniq -d > $fE
		cat $fB $fE |sort| uniq -u | shuf | head -n 1 >> $fC
	done
	rm $fA $fB $fE


} #}}}
RADIOsignoff()
{ #{{{ ----- RADIOsignoff
$signoffEcho
$signoffEspeak
	sleep 2
exit

} #}}}
BLOCKcallsign()
{ #{{{ BLOCKcallsign
cd $dir_lib
musak=$(ls -A --format=single-column | grep .mp3 | shuf | head -n 1)
D=$(soxi -D $musak| sed 's/^\(.\{1\}\).*/\1/');
slpA=$(expr "$D" - 2)
	# Set up callsign:
linesA=$(sed -n '$=' callsign.spool) #counts lines in file
A=$(seq $linesA | shuf | tail -n 1)
callsign=$(head -n $A callsign.spool| tail -n 1)
	# Play advert, musak, and sleep:
#play -q "$musak"& 
$espeak "$callsign"&

} #}}}
BLOCKsongID()
{ #{{{  BLOCKsongID
	sArt=$(soxi "$clip" | grep Artist | sed 's/Artist\=//')
	sTtl=$(soxi "$clip" | grep Title | sed 's/Title\=//')
	sAlb=$(soxi "$clip" | grep Album | sed 's/Album\=//')

} #}}}
BLOCKplay_0()
{ #{{{ ----- BLOCKplay
	# Source format:
. $dir_lib/$Format.format
 # NECESSARY VARIABLES:
	runtime="$radiotimer minute"
	endtime=$(date -ud "$runtime" +%s)
	nextSongDelay=2
	l1="lolcat -f -F .03"
#
cd $dir_music
while [[ $(date -u +%s) -le $endtime ]]
do
	if [[ ! -s $fC ]] ; then RADIOqueue; fi
	clipM=$(head -n 1 $fC);
	D=$(soxi -D "$clipM" | sed 's/^\(.\{3\}\).*/\1/ ; s/\.//');
	pidLast=$pid;
	clear
	clip=$clipM && BLOCKsongID
	echo -en "\"$sTtl\" "|$l1 && echo -en "by " && echo -en "$sArt" | $l1
	if [ "$sAlb" != "" ] ; then
			echo -en "\n\tfrom the album " && echo -en "\"$sAlb\".\n"| $l1 
	fi
	clip=$clipL && BLOCKsongID
	headerLast="\n You just heard \"$sTtl\" by $sArt."
	slp=$(expr "$D" - $nextSongDelay);
	echo $clipM > $fB >> $fD 
	clipL="$clipM"
	if [ "$pid" != "" ] ; then
		echo -en "$headerLast"&
	fi
	play "$clipM" 2>&5 & 
	sleep 60 && slp=$(expr $slp - 60)
	clear
	clip=$clipM && BLOCKsongID
	echo -en "\"$sTtl\" "|$l1 && echo -en "by " && echo -en "$sArt.\n" | $l1 
	echo
	#ls ~/Documents/ | shuf -n 1 | cat | sgpt "summarize in the form of a fortune." #| fold -w $(tput cols) -s
	pid=$(echo $!);
	sed -i '1d' $fC;

	#lineSpace=$(expr $(tput lines) - 4) 
	#while [ $lineSpace != "1" ]; do
#			echo -en "\nline space left = $(expr $lineSpace - 1)"
#			lineSpace=$(expr $lineSpace - 1)
#	done
#	BLOCKprintAdvrts&
	sleep $(expr $slp - 35) 
	clear
	clip=$clipM && BLOCKsongID
	echo -en "That was " && echo -en "\"$sTtl\" "|$l1 && echo -en "\n\tby " && echo -en "$sArt." | $l1 
#	if [ "$sAlb" != "" ] ; then
#		echo -en "\n\tfrom the album " && echo -en "\"$sAlb\".\n"|$l1
#	fi
	clipN=$(head -n 1 $fC);
	clip=$clipN && BLOCKsongID
#	sleep $(expr $slp - 15) && echo -en "\n\nUp next is \"$sTtl\" by \"$sArt\"." |lolcat -F .03 &
	echo -en "\n\nUp next is " && echo -en \"$sTtl\"|$l1 && echo -en " by " && echo -en \"$sArt\"|$l1
#	read -r -n 1 -d $'\n -p 'input>' x
#	echo x;
	sleep 35
done
	BLOCKbreak

} #}}}
BLOCKplay()
{ #{{{ ----- BLOCKplay
 # NECESSARY VARIABLES:
	radiotimer=25
	runtime="$radiotimer minute"
	endtime=$(date -ud "$runtime" +%s)
	nextSongDelay=2
	l1="lolcat -f -F .03"
#
cd $dir_music
while [[ $(date -u +%s) -le $endtime ]]
do
	if [[ ! -s $fC ]] ; then RADIOqueue; fi
	clipM=$(head -n 1 $fC);
	D=$(soxi -D "$clipM" | sed 's/^\(.\{3\}\).*/\1/ ; s/\.//');
	pidLast=$pid;
	clear
	clip=$clipM && BLOCKsongID
	echo -en "\"$sTtl\" "|$l1 && echo -en "by " && echo -en "$sArt" | $l1
	if [ "$sAlb" != "" ] ; then
			echo -en "\n\tfrom the album " && echo -en "\"$sAlb\".\n"| $l1 
	fi
	clip=$clipL && BLOCKsongID
	headerLast="\n You just heard \"$sTtl\" by $sArt."
	slp=$(expr "$D" - $nextSongDelay);
	echo $clipM > $fB >> $fD 
	clipL="$clipM"
	if [ "$pid" != "" ] ; then
		echo -en "$headerLast"&
	fi
	play "$clipM" 2>&5 & 
	sleep 60 && slp=$(expr $slp - 60)
	clear
	clip=$clipM && BLOCKsongID
	echo -en "\"$sTtl\" "|$l1 && echo -en "by " && echo -en "$sArt.\n" | $l1 
	echo
	#ls ~/Documents/ | shuf -n 1 | cat | sgpt "summarize in the form of a fortune." #| fold -w $(tput cols) -s
	pid=$(echo $!);
	sed -i '1d' $fC;

	#lineSpace=$(expr $(tput lines) - 4) 
	#while [ $lineSpace != "1" ]; do
#			echo -en "\nline space left = $(expr $lineSpace - 1)"
#			lineSpace=$(expr $lineSpace - 1)
#	done
#	BLOCKprintAdvrts&
	sleep $(expr $slp - 35) 
	clear
	clip=$clipM && BLOCKsongID
	echo -en "That was " && echo -en "\"$sTtl\" "|$l1 && echo -en "\n\tby " && echo -en "$sArt." | $l1 
#	if [ "$sAlb" != "" ] ; then
#		echo -en "\n\tfrom the album " && echo -en "\"$sAlb\".\n"|$l1
#	fi
	clipN=$(head -n 1 $fC);
	clip=$clipN && BLOCKsongID
#	sleep $(expr $slp - 15) && echo -en "\n\nUp next is \"$sTtl\" by \"$sArt\"." |lolcat -F .03 &
	echo -en "\n\nUp next is " && echo -en \"$sTtl\"|$l1 && echo -en " by " && echo -en \"$sArt\"|$l1
#	read -r -n 1 -d $'\n -p 'input>' x
#	echo x;
	sleep 35
done
	BLOCKbreak

} #}}}
BLOCKbreak()
{ #{{{ BLOCKbreak
cd $dir_lib
	buzzer=$(head -n $Al alarm.spool| tail -n 2 | head -c 2 )
		# run advrt, run alarm, or sign off:
if [[ $(date +%H) < 22 ]] && [[ $buzzer < $(date +%H) ]] ;then
	BLOCKadvrt
	RADIOjunction;
elif [[ $(date +%H) < 22 ]] && [ $buzzer >= $(date +%H) ] ;then
	BLOCKalarm;
	RADIOjunction;
else
	BLOCKsignoff
fi

} #}}}
BLOCKadvrt()
{ #{{{ BLOCKadvrt
musak=$(ls -A --format=single-column | grep .mp3 | shuf | head -n 1)
D=$(soxi -D $musak| sed 's/^\(.\{1\}\).*/\1/');   # Set sleep length
slpA=$(expr "$D" - 2)
		# Set up advert:
	linesA=$(sed -n '$=' advrt.spool) #counts lines in file
	A=$(seq $linesA | shuf | tail -n 1)
	advrt=$(head -n $A advrt.spool| tail -n 1)
		# Play advert, musak, and sleep:
	play -q "$musak"&
	$espeak "$advrt"&
	sleep $slpA

} #}}}
STATIONsignoff()
{ #{{{ BLOCKsignoff
	sleep 5
	echo "Tune in again next time!" 
	echo $espeak "Tune in again next time!"&
	RADIOjunction

} #}}}
KillAll()
{ #{{{
if [ -z $(ps ax |grep $s| grep -iv grep | head -n 1 | awk '{ print $1 }') ] ; then
	echo "$(date +%a_%m%d%y_%T) Initializing radiod." >&3
	$s&
fi

} #}}}

   ###  MAIN PROGRAM EXECUTION
ACTIFY

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
### Code snippets
###
#!/bin/sh
set +v; set +x; set -e; set +u
# set -u       # set program to exit if no positional parameters provided by user.
# ~/bin/PROGRM.sh
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
	echo "USAGE:  PROGRM [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  DSCR"
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
file_log_0=$HOME/var/log/PROGRM_0.log && fl0=$file_log_0
file_log_1=$HOME/var/log/PROGRM_1.log && fl1=$file_log_1
file_log_2=$HOME/var/log/PROGRM_2.log && fl2=$file_log_2
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
s="Initializing PROGRM.sh..." && App_LOG #&& App_ECHO
  #
App_PREP      # Create necessary files and directories, set daemon status
  #
  # Start main application:
if [ $daemon = "y" ] ; then
	App_START&  # adding & at the end of a command runs it in the background.
	s="Starting PROGRM as daemon; exiting to terminal." && App_ECHO && App_LOG
else
	App_START   # Program will run in termimal until complete.
	s="Exiting PROGRM.sh." && App_LOG #&& App_ECHO
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
dir_conf=$HOME/.config/PROGRM
dir_home=$HOME/PROGRM
dir_lib=$HOME/lib/PROGRM && lib=$dir_lib
dir_log=$HOME/var/log
dir_var=$HOME/var/PROGRM && var=$dir_var
file_conf_0=$HOME/.config/PROGRM/PROGRM.conf
file_log_0=$HOME/var/log/PROGRM.log
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
  Exec_MAIN

} #}}}
Exec_MAIN()
{ #{{{  ----- Exec_MAIN:  execute command
  #
  s="Executing main command." && App_LOG
  #
  # Main command:
  s="Echoed \"hello world\"."
  echo "hello world"

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
