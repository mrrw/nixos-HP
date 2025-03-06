#!/bin/bash
set +v; set +x; set -e; set -u
# ~/bin/radio.sh
# by Michael Milk (mrrw.github)
# See EOF for known issues and bugs.
cd ~
#~/.radio/.error.log 2>&1
#
# Sources: 
[[ -a /home/$USER/bin/.sh.conf.sh ]] && . /home/$USER/bin/.sh.conf.sh 
. ~/bin/libmrrwCommands.sh
[[ -a ~/.config/radio/commands.conf ]] && . ~/.config/radio/commands.conf
[[ -a ~/.radio/libradioformat.sh ]] && . ~/.radio/libradioformat.sh

#
Help()
{
	#Display Help.
	echo "USAGE:  radio [--options]; [user input]; [user input]"
  echo "        radio -p [filename]"
  echo "        radio -S [filename]"
	echo "        radio  (plays a radio programming block by default.)"
	echo ""
	echo "DESCRIPTION:  Command line radio simulator that plays locally-stored music."
	echo ""
	echo "OPTIONS:"
	echo "-C	Open control console."
	echo "-f	Apply various formats as defined in format.conf."
	echo "-h	Display this help."
	echo "-m	Mute the radio."
	echo "-P	Play file if listed in ~/.radio/.playlist.tmp"
	echo "-s	Skip current song."
	echo "-S	Select station."
	echo "-v	Verbose mode."
	echo "-x	Trace/Debug mode."
	echo
}
# Get the options:
# {{{
while getopts ":cCfhmprRsStTvx" option; do
	case $option in
		C | CONSOLEcontrol)
		CONSOLEcontrol
		;;
		f | --format)
			filename=$2
			format    ;;
		h) # display help
			Help      ;
			exit      ;;
		m | --mix)
			mix       ;	
			exit      ;;
		p | --play | --playsong | --songplay)
			filename=$2;
			songplay  ;
			exit      ;;
		r | --record)
			filename=$2;
			record    ;
			exit      ;;
		R | --RadioStart)
			RadioStart
			          ;;
		s | --songplay | --playsong)
			songplay  ;
			exit      ;;
		S | --Stations)
		  S=Stations
		            ;;
		t | --take)
			take      ;
			exit      ;;
		T | --Test)
			TestScript;;
		v) # verbose mode
			set -v		;;
		x) # trace mode
			set -x		;;
	  \?) # invalid option
			echo "Error: Invalid option."
			exit;;
	esac
done
# }}}

### Set some variables:
#
radioDIR=~/.radio  # Default directory is ~/.radio
station=station
alarm="n"
search=
ext=.mp3
pid=
Al=2 # called by BLOCKalarm.  2 is the starting point.
espeak="espeak -s 120 -p 10 -v en-us+f5" #Default voice.
	fA="$radioDIR/.artistlist.tmp"
	fB="$radioDIR/.queuesong.tmp"
	fC="$radioDIR/.playlist.tmp"
	fD="$radioDIR/.ignoretoday.tmp"
	fE="$radioDIR/.queueignore.tmp"
	fF="$radioDIR/$station.ignore"
# Set voice:
	touch $fA $fB $fC $fD $fE
### Define commands:
#
RADIOformat()
{ #{{{ RADIOformat

	d=$radioDIR && ADMINcd
	stationLAST=$station
	case $(date +%H) in
01 | 02 | 03 | 04 | 05 | 06 | 22 | 23 | 24 | 00)
		RADIOsignoff ;;
			07) station=station ;;
			08) station=station ;;
			09) station=station ;;
			10) station=station ;;
			11) station=station ;;
			12) station=station ;;
			13) station=station ;;
			14) station=station ;;
			15) station=station ;;
			16) station=station ;;
			17) station=station ;;
			18) station=station ;;
			19) station=station ;;
			20) station=station ;;
			21) station=station ;;
	esac
# Default to station.station if current $station is empty:
[[ ! -s $(wc -l $station.station) ]] && station="station"
# check if the last station played will continue:
	if [[ $stationLAST == $station ]] && [[ -s .playlist.tmp ]]; then
		STATIONcontinue
	else
		. $station.station
		STATIONstart
	fi
} #}}}
RADIOsignoff()
{ #{{{ RADIOsignoff

	d="$radioDIR" && ADMINcd
	touch $fA $fB $fC $fD $fE
	rm $fA $fB $fC $fD $fE
	#musak=$(ls -A | grep *bye.mp3 | shuf | head -n 1)
	#play $musak &
	sleep 5
	echo "Tune in again at 7 AM!" 
	$espeak "Tune in again at seven hey em!"&
	exit
} #}}}
RADIOstart()
{ #{{{ RadioStart

	[[ -a ~/.radio/.playlist.tmp ]] && rm ~/.radio/.playlist.tmp
	ignoreDate=$(stat --format=%w $fD | head -c 10 | tail -c 2)
	if [ "$(date +%d)" != "$ignoreDate" ] ; then
		rm $fD && touch $fD
	fi
	RADIOformat
#	CONSOLEcontrol
} #}}}
CONSOLEcontrol()
{ #{{{ CONSOLEcontrol

ADMINcd
consoleLIST="New Add Jobs Remove Skip"
sleep 1
echo "$consoleLIST"
select console in $consoleLIST; do
	case $console in
	New)	
		echo "Name your new station:"
		read stat
		echo "$clipM" >> ~/.radio/$stat.station
		echo "$clipM has been added to $stat.station."
		;;
	Add) 
		select stat in $(ls -A | grep station); do
			echo "$clipM" >> $stat.station
		done
		echo "$clipM has been added to $stat.station."
		;;	
	Jobs)
		jobs
		;;
	Remove)
		touch ~/.radio/.ignore
		echo "$clipM" >> ~/.radio/.ignore
		kill $!
		echo "$clipM has been removed from rotation."
		BLOCKplay
		;;
	Skip)
		kill $!
		BLOCKplay
	esac
done
#
#		Pause)
#		fg $pid
#
#		kill $pid
#
#esac
#done
#Remove #from current playlist, or add to .ignore
#Add #to select playlist.
#Undo #yikes, HOW?!
#Redo #neat trick, I'm sure
#Hold/Pause #current song
} #}}}
TestScript ()
{ #{{{

cd; set -x
	play -q test.wav&
	#pid=$(echo $!)
#	%1
	#%-
	#%+
	#echo $pid
	#kill $pid
	echo $!
	#kill $!
exit
#
if [[ $(date +%H) < 22 ]] ; then
		echo "before 10pm, no alarm.";
elif [[ $(date +%H) > 22 ]] ; then
		echo "after 10pm, yes alarm."
else
		# sign off, since it's after 10pm:
	echo $(date +%H)
	echo "Tune in again at seven hey em!" 
fi
# The following while statements might help me stop the radio at 10:00pm.
while [ $(date +%H+M) < 2200 ]; do
	echo "noice" && sleep 5
done
while [ $(date +%H+M) > 2200 ]; do
	echo "oice" && sleep 5
done
#select station in $(tree -if | grep .station)
		cd ~/.radio/advrt
ad=".0"
k=$(tree -if | grep .mp3 | wc -l)
musak=".$(seq $k | shuf | head -n 1).mp3"
musak=$(ls -A --format=single-column | shuf | head -n 1)
	echo $musak
	exit
} #}}}
#
### PROGRAM EXECUTION

RADIOstart
#trap BLOCKskip 
#
### Next level-up:
#. ~/.radio/station.station
#	bDefine && bBlock
