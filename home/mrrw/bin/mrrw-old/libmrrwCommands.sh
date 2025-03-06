#!bin/bash
#
# Library of common commands, by and for mrrw.
# d=dir, f=file, n=number, r=response, s=string x/y/z=integers

ADMINcd()
{ #{{{ ADMINcd
	cd "$d"

} #}}}
ADMINcdAsk()
{ #{{{ ADMINcdAsk
	if [[ ! -d "$d" ]] ; then
			echo -en "$d does not exist.  Create it? \n"
			read r
		if [[ $r == y ]] ; then
			mkdir -p "$d" && cd "$d"
		else
			echo -en "Type the name of the new directory:  "
			read d
			mkdir -p "$d" && cd "$d"
		fi
	else
		cd "$d"
	fi

} #}}}
ADMINcdForce()
{ #{{{ ADMINcd
	[[ ! -d "$d" ]] && mkdir "$d"
	cd "$d"

} #}}}
ADMINclipLine()
{ #{{{ ADMINclipLine
	s=$(head -n 1 $f) ;
	sed -i '1d' $f

} #}}}
#ADMINclipLines()
#{ #{{{ ADMINclipLines
#	clip=$(head -n 1 $sourceFILE) ;
#	sed -i '1d' $sourceFILE

#} #}}}
ADMINfeedAdd()
{ #{{{ ADMINfeedAdd
	echo $s >> $f

} #}}}
ADMINfeedPipe()
{ #{{{ ADMINfeedPipe
	echo #$s | 

} #}}}
ADMINfeedReplace()
{ #{{{ ADMINfeedReplace
	echo $s > $file

} #}}}
ADMINignore()
{ #{{{ ADMINignore
	read ignore <$s
	echo $ignore

} #}}}
ADMINsearch()
{ #{{{ ADMINsearch
	tree -if | grep $s

} #}}}
GITadd()
{ #{{{ GITadd
		git add $f

} #}}}
GITcommitA()
{ #{{{ GITcommitA
		git commit -a

} #}}}
GITcommitB()
{ #{{{ GITcommitB
		git commit -a -m "$s"

} #}}}
GITpull()
{ #{{{ GITpull
	git pull

} #}}} 
GITpullNR()
{ #{{{ GITpullNR
	git pull --no-rebase

} #}}}
GITpush()
{ #{{{ GITpush
	git push

} #}}}
SLEEPset()
{ #{{{ ADMINsleepSet
	slp=$x

} #}}}
SLEEPgo()
{ #{{{ ADMINsleepGo
	sleep $slp

} #}}}
TIMERwatch()
{ #{{{ BLOCKbreak
		[[ -a .alarm.spool ]] && alarm=$(head -n 1 .alarm.spool)
while [[ $(date +%H%M) < $timeout ]] && [[ $alarm < $(date +%H%M) ]]; do
		$pathA; # While the timeout hasn't been reached, nor an alarm.
done
while [[ $(date +%H%M) < $timeout ]] && [ $alarm >= $(date +%H%M) ]; do
		$pathB; # While the timeout hasn't been reached, but an alarm has.
done
while [ $(date +%H%M) >= $timeout ]; do
		$pathC  # When the timeout has been reached.
done

} #}}}
TIMERcheck()
{ #{{{ BLOCKbreak
		[[ -a .alarm.spool ]] && alarm=$(head -n 1 .alarm.spool)
if [[ $(date +%H%M) < $timeout ]] && [[ $alarm < $(date +%H) ]] ;then
		$pathA; # If the timeout hasn't been reached, nor an alarm.
elif [[ $(date +%H%M) < $timeout ]] && [ $alarm >= $(date +%H) ] ;then
		$pathB; # If the timeout hasn't been reached, but an alarm has.
else
		$pathC  # If the timeout has been reached.
fi

} #}}}

BLOCKalarm()
{ #{{{ BLOCKalarm

		# Set up musak:
	musak=$(ls -A --format=single-column | grep .mp3 | shuf | head -n 1)
		# Set sleep length:
	D=$(soxi -D $musak| sed 's/^\(.\{1\}\).*/\1/');
	slpA=$(expr "$D" - 2)
		# Set up alarm:
	alarm=$(head -n $Al alarm.spool| tail -n 1)
		# Play advert, musak, and sleep:
	play -V0 "$musak"&
	$espeak "$alarm"&
	Al=$(expr $Al + 2)
	sleep "$slpA"
} #}}}
BLOCKcallsign()
{ #{{{ BLOCKcallsign

homeDIR="$advrtDIR" && ADMINcd
musak=$(ls -A --format=single-column | grep .mp3 | shuf | head -n 1)
# Audio callsign:
#callsing=$(ls -A --format=single-column | grep .mp3 | shuf | head -n 1)
	# Set sleep:
D=$(soxi -D $musak| sed 's/^\(.\{1\}\).*/\1/');
slpA=$(expr "$D" - 2)
	# Set up callsign:
ADMINcd
linesA=$(sed -n '$=' callsign.spool) #counts lines in file
A=$(seq $linesA | shuf | tail -n 1)
callsign=$(head -n $A callsign.spool| tail -n 1)
	# Play advert, musak, and sleep:
play -V0 "$musak"&
$espeak "$callsign"&
} #}}}
BLOCKformat()
{ #{{{ BLOCKformat

	ADMINcd
	case $(date +%H) in
01 | 02 | 03 | 04 | 05 | 06 | 22 | 23 | 24 | 00)
		echo "Tune in at 7am!" && exit ;;
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
		BLOCKcallsign;
		BLOCKplay
	else
		BLOCKshuffle
		BLOCKcallsign;
		BLOCKplay
	fi
} #}}}
BLOCKplay()
{ #{{{ BLOCKplay

	runtime="$t minute"
	endtime=$(date -ud "$runtime" +%s)
#
	while [[ $(date -u +%s) -le $endtime ]]
	do
		
		pid=$(echo $!)
		echo $pid
		pid2=$pid 
		{sleep $nextSongDelay && kill $pid2}
	done
	BLOCKbreak&
} #}}}
BLOCKshuffle()
{ #{{{ BLOCKshuffle

	target=~/.radio/$station.station
	a=$(cat $target | wc -l)
	b=$(cat $target | grep HEADER | wc -l)
	tail -n $(expr $a - $b) $target | shuf > .playlist.tmp
} #}}}
BLOCKsignoff()
{ #{{{ BLOCKsignoff

	$espeak "Tune in again at seven hey em!" 
	exit
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
# MAIN COMMANDS
mix()
{ #{{{ mix

	homeDIR="$audioDIR" && ADMINcd
	ls
	select filename in $(ls ~/$audioDIR)
	do
		take=$(echo $filename | sed 's/\.mp3// ; s/\.wav//')
		mix=$(echo -en $(ls | grep $take) )
		play -m $mix
		echo $mix
	done
} #}}}
record()
{ #{{{ record

	homeDIR="$audioDIR" && ADMINcd
	rec "$filename"
} #}}}
RadioStart()
{ #{{{ RadioStart

	[[ -a ~/.radio/.playlist.tmp ]] && rm ~/.radio/.playlist.tmp
	BLOCKformat
#	CONSOLEcontrol
} #}}}
songplay()
{ #{{{

	targetDIR=~; search="$filename"; searchFILE=".songsearch.tmp"
	ADMINsearch
	if [[ $(sed -n '$=' ~/.radio/.songsearch.tmp) == 1 ]] ; then
		song=$(head ~/.radio/.songsearch.tmp);
		play $song;
		exit
	else
		cat -n ~/.radio/.songsearch.tmp
		echo -en "Enter the number of the song of your choice:"
		read p
		song=$(head -n $p ~/.radio/.songsearch.tmp| tail -n 1)
		play "$song"
	fi
	rm ~/.radio/.songsearch.tmp
} #}}}
Stations()
{ #{{{

	targetDIR="$stationDIR"; search="$filename"; searchFILE=".songsearch.tmp"
	ADMINsearch
} #}}}
take()
{ #{{{

	homeDIR="$audioDIR" && ADMINcd
	datetime=$(date +%j%H%M)
	ls
	select filename in $(ls ~/$audioDIR)
	do
		take=$(echo $filename | sed 's/\.mp3// ; s/\.wav//')
		name=$(echo ""$take""$datetime"".wav"")
		echo $name
		rec "$name"& play "$filename"
		kill %1
	done
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

	#id3v2 -l "$s";

# Source gitPush by mrrw:
#. /home/$USER/bin/gitPush.sh

###  BEGIN ISSUES

#####  NOTES
#
# To-Do
# 
# Musak:  4 sec, 10 sec, 30 sec, & 60 sec bursts
# Announcements:  10 sec, 30 sec, and 60 sec
#

