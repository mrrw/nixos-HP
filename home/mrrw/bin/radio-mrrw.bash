#!/bin/bash
## ...by mrrw, @2025
# See App_PREP() for program variables, sources, and directories.
# See end of file for known issues and bugs.
# Dependencies include:  sox, libsox-fmt-all
set +v; set +x; set -e; set +u
# set -u  # set program to exit if no positional parameters provided by user.

options="hlvx"
Help()
{
	#Display Help.
	echo "USAGE:  wcli-radio [--options]; [user input]; [user input]"
	echo "DESCRIPTION:  Play music seemlessly as a daemon.  Customizable."
	echo "              Dependencies include:  sox, libsox-fmt-mp3."
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
while getopts ":$options" option; do
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

MASTER-COMMAND() {  ## DO NOT EDIT THIS FUNCTION.
setDefaults
prepDirectories
}
setDefaults() {  ## DO NOT EDIT THIS FUNCTION.
	DIR_config="$HOME/.config/wcli-homeradio"
	DIR_music="$HOME/Music"
	DIR_lib="$HOME/lib/wcli-homeradio"
}

makeDIR(){ [ ! -d $DIR_config ] && mkdir -p $DIR_config
}
chooseDIR() { ## define the default music directory in the absence of one
	PS3="Let's find and define the default music directory.  Pick a path."
	select DIR in $(ls) ; do
		echo "Is $DIR your final answer?" 
		read r && if [[ $r = "n" ]] ; then
			\cd $DIR 
			ls
		else
			echo $DIR > $DIR_config/musicDirecory.rc
			break
		fi
	done
}
fetchDIR() { ## find the default music directory
	[ ! -d $DIR ] && DIR=""
	if [[ $DIR = "" ]] ; then
		chooseDIR
	else
		echo $DIR
	fi
}
DIR=$HOME/Music && fetchDIR

   #
   ###  PROGRAM COMMANDS
   #
App_ECHO() { echo -e "$s" ; }
App_LOG() { echo -e "$(date +%a_%m%d%y_%T) $s " >&3 ; }
App_MESSAGE() { echo -e "$(date +%a_%m%d%y_%T) $s " > $dir_message/message.txt ; }
App_RUN()
{ #{{{  ----- App_RUN:  Initialization and termination
  SetLogs()
  { #{{{
    file_log_0=$HOME/var/log/wcli_0.log && fl0=$file_log_0
    file_log_1=$HOME/var/log/wcli_1.log && fl1=$file_log_1
    file_log_2=$HOME/var/log/wcli_2.log && fl2=$file_log_2
  # curate logs:
    [ -s $fl1 ] && mv $fl1 $fl2
    [ -s $fl0 ] && mv $fl0 $fl1
  # open main log:
    exec 3<> $fl0                    # Open log under file descriptor 3
s="Initializing wcli-radio.bash..." && App_LOG #&& App_ECHO
  } #}}}
  SetOutput()
  { #{{{
    #exec 2>&3                        # Redirect stderr to $file_log_0
    exec 4<> /dev/pts/3              # Open tty 3 for sending user messages, fd 4
    exec 6<> /dev/pts/4              # Open tty 4 for sending user messages, fd 6
    #exec 1>&4                        # Send all stdout to tty 4
  } #}}}
  Sourcing()
  { #{{{
		echo > /dev/null  ## PLACEHOLDER COMMAND PREVENTS FUNCTION ERROR.
#. $HOME/bin/.sh.conf.sh 
#. $HOME/bin/libmrrwCommands.sh
  } #}}}
  Directories()
  { #{{{
  # Standardized variables for files and directories:
dir_conf=$HOME/.config/wcli-radio
dir_home=$HOME/wcli-radio
dir_lib=$HOME/lib/wcli-radio && lib=$dir_lib
dir_log=$HOME/var/log/wcli-radio
dir_var=$HOME/var/wcli-radio && var=$dir_var
file_conf_0=$HOME/.config/wcli-radio/wcli.conf
file_log_0=$HOME/var/log/wcli-radio.log
dir_hash=$dir_lib/songhashes
  # 
  s="Looking for missing directories..." && App_LOG
[ ! -d $dir_conf ] && mkdir -p $dir_conf  && s="Creating $dir_conf." && App_LOG
#[ ! -d $dir_home ] && mkdir -p $dir_home  && s="Creating $dir_home." && App_LOG
[ ! -d $dir_lib ] && mkdir -p $dir_lib  && s="Creating $dir_lib." && App_LOG
#[ ! -d $dir_log ] && mkdir -p $dir_log  && s="Creating $dir_log." && App_LOG
[ ! -d $dir_var ] && mkdir -p $dir_var  && s="Creating $dir_var." && App_LOG
[ ! -d $dir_hash ] && mkdir -p $dir_hash  && s="Creating $dir_hash." && App_LOG
echo 
#
  } #}}}
  Run()
  {
    daemon=n      # A daemon is an application that runs in the background. 
                  # This frees up the terminal for further use, while
                  # making it harder for the user to terminate the program.
    if [ $daemon = "y" ] ; then
       s="Starting wcli as daemon; exiting to terminal." && App_ECHO && App_LOG
      Exec_wcli&  # adding & at the end of a command runs it in the background.
    else
       s="Executing wcli main program." && App_LOG #&& App_ECHO
      Exec_wcli   # Program will run in termimal until complete.
       s="Exiting wcli.bash." && App_LOG #&& App_ECHO
    fi
  }
# App_RUN:
SetLogs && SetOutput && Sourcing && Directories
Run && exit

} #}}}
Exec_wcli()
{ #{{{  ----- WCLI:  main command
	SETUP()
	{ #{{{
  	NameFiles()
  	{ #{{{
     f0=$dir_var/.tmp
     f1=$dir_var/playlist.spool
     f2=$dir_var/ignore.today
     f3=$dir_var/queue.spool
     fc0=$dir_conf/music.conf
     fc1=$dir_conf/voice.conf
     fc2=$dir_conf/message.conf
  	 fv0=$var/.tmp
  	 fv1=$dir_var/playcount.log
  	} #}}}
  	MakeFiles()
  	{ #{{{
  	 if [ ! -s fc0 ] ; then
  		 echo -n '' > $fc1
  	 fi
  	 if [ ! -s fc1 ] ; then
  		 echo 'default_voice="espeak -s 120 -p 10 -v en-us+f5"' > $fc1
  		 echo 'voice=$default_voice' >> $fc1
  	 fi
     Format=""
  	} #}}}
	  SourceFiles()
    { #{{{  ---  SourceFiles
	    s="  Sourcing files..." && App_LOG
	    dir_music="" && [ -s $fc0 ] && . $fc0
			voice="" && [ -s $fc1 ] && . $fc1
			message="" && [ -s $fc2 ] && . $fc2
		  echo  # Program fails without this line, for some reason.
    } #}}}
  	Database()
    { #{{{
      InitiateDatabase() 
      { #{{{
  	  s="  Initiating database." && App_LOG
        database="music_database.csv"
       echo "Artist,Album,Song,Publication Date,Length,Play Count,Intensity Ranking,Path" > "$database"
      } #}}}
  	  BuildDatabase()
  		{ #{{{
				s="  Building database..." && App_LOG
				BuildHash()
				{ #{{{
					n=0
				  f_spect=$var/spectrogram.png
	  	    sox "$song" -n spectrogram -m -o $f_spect
          intensity=$(grep -o -E '[[:alpha:]]' < <(jp2a $f_spect) | wc -l)
		  		echo -e "Path=\"$song\"" > $f_hash
		      echo -e "Length=\"$(soxi -D $song | awk -F. '{print $1}')\"" >> $f_hash
          soxi -a $song | sed "s/=/=\"/g;s/$/\"/" >> $f_hash
		  		echo -e "Intensity=\"$intensity\"" >> $f_hash
		  		echo -e "Playcount=\"$n\"" >> $f_hash
				#	echo >> $f_hash
					#jp2a $f_spect >> $f_hash
				} #}}}
      # Loop through each song in the directory
			s="dir_music is $dir_music" && App_LOG
      IFS=$'\n'
      for song in $(tree -nif "$dir_music" | grep -i ".mp3" | shuf); do
				songhash=$(echo $song | md5sum | cut -d ' ' -f 1)
			  s="    songhash = $songhash" && App_LOG
				f_hash=$dir_hash/$songhash
					if [[ $songhash != $(ls $dir_hash | grep $songhash) ]] ; then
						BuildHash
						s="  Built $songhash" && App_LOG
					fi
				. $f_hash
        echo "\"$Artist\",\"$Album\",\"$Title\",\"$Year\",\"$Length\",\"$Playcount\",\"$Intensity\",\"$Comment\",\"$Path\"" >> "$database"
			  s="    Added $Title to database." && App_LOG
				
        #soxi -a $song > $fv0
		    #title=$(head -n 1 $fv0 | awk -F'=' '{print $2}')
		    #artist=$(head -n 2 $fv0 | tail -n 1 | awk -F'=' '{print $2}')
		    #album=$(head -n 3 $fv0 | tail -n 1 | awk -F'=' '{print $2}')
		    #track=$(head -n 4 $fv0 | tail -n 1 | awk -F'=' '{print $2}')
		    #year=$(head -n 5 $fv0 | tail -n 1 | awk -F'=' '{print $2}')
		    #comment=$(head -n 6 $fv0 | tail -n 1 | awk -F'=' '{print $2}')
		    #length=$(soxi -D $song | awk -F. '{print $1}')
			  #path="$song"
		    #if [ -s $fv1 ] ; then playcount=$(grep -c "$song" $fv1)
				#else playcount=0 ; fi
        # Append data to the database
      done
	#while IFS= read -r f ; do
#		music+=("$f")
#	done < <(tree -nif $dir_music | grep -i mp3)
#song_total=$(printf "%s\n" "${music[@]}" | wc -l)
#for e in "${music[$(seq $song_total | shuf | head -n 1)]}" ; do
#	echo $e
#done
		  } #}}}
      RemoveSilence()
      { #{{{
  	    s="  Removing silence..." && App_ECHO
      song="your_song_file.mp3"  # Replace 'your_song_file.mp3' with your actual file
        # Get the duration of the song using SoX
      duration=$(sox --i -D "$song")
        # Detect and remove trailing silence at the end
      sox "$song" "${song%.mp3}-trimmed.mp3" reverse silence 1 0.1 1% reverse
      echo "Silence at the end removed. Trimmed file saved as ${song%.mp3}-trimmed.mp3"
      } #}}}
		InitiateDatabase && BuildDatabase
    } #}}}
    FindMusic()
    { #{{{  ---  FindMusic
    #
	  s="  WCLI -- FindMusic" && App_LOG
		clear
		echo
		s="  First thing's first:  we have to locate the directory" && App_ECHO
		s="  where your music is stored.  This might take a minute." && App_ECHO
		  Find()
	    { #{{{
		suffixes=("mp3" "flac" "ogg" "wav")
		cd
	master=$var/dirMusicFIND_master.tmp
	[ -s $master ] && rm $master
	for s in "${suffixes[@]}" ; do
		f=$var/dirMusicFIND_$s.tmp
		tree -nif | grep -i ".$s" | sed 's![^/]*$!!' | sort -u | sed 's/./$HOME/' > $f 
		while [ -s $f ] ; do
			s1=$(head -1 $f) 
			s2=$(head -2 $f | tail -1)
			alias mawk="awk -F'/' -v RS='/' 'NR==FNR{a[$0];next} $0 in a'"
			s_common=$(awk -F'/' -v RS='/' 'NR==FNR{a[$0];next} $0 in a' <(echo $s1) <(echo $s2) | sed '/^\s*$/d' | tr '\n' '/')
			echo $s_common >> $master ; sed -i '1d' $f
		done
		rm $f
	done
	f=$f0 #tmp file
	sort -u $master > $f 
	rm $master
		while [ -s $f ] ; do
			s1=$(head -1 $f) 
			s2=$(head -2 $f | tail -1)
			s_common=$(awk -F'/' -v RS='/' 'NR==FNR{a[$0];next} $0 in a' <(echo $s1) <(echo $s2) | sed '/^\s*$/d' | tr '\n' '/' | sed 's/\/$//')
			echo $s_common >> $master ; sed -i '1d' $f
		done
	f=$f0 #tmp file
	sort -u $master > $f 
      } #}}}
	    Show()
	    { #{{{
		echo
		s="  We found several possible locations for your music library:" && App_ECHO
		PS3="  Please select the directory where you store your music.  " 
		select r in $(cat $f) ; do
			dir_music=$r
			echo "dir_music=$dir_music" >> $fc0
			break
		done
	    } #}}}
    Find && Show
	  [ -s $master ] && rm $master
	  } #}}}
		Welcome()
		{ #{{{
		clear
		echo
	s="  Welcome to WCLI, where the music chooses you!" && App_ECHO && App_LOG
	sleep 1.8
	#echo $dir_music && exit
		} #}}}
NameFiles && MakeFiles && SourceFiles
if [[ $dir_music == "" ]] ; then 
	FindMusic
  Database 2>&3 & 
  s="  Setup complete.  Building database in background."  && App_LOG
	sleep 2
else
	Database 2>&3 &
	s="  Setup complete.  Building database in background."  && App_LOG
fi
Welcome
  } #}}}
	AIRPLAY()
  { #{{{
	songtotal=${#database[@]}
		ChooseRandom()
		{ #{{{
			f_hash=$dir_hash/$(ls $dir_hash | shuf | head -n 1)
			. $f_hash
			if [[ "$Title" != "" ]] ; then
				s="    Randomly selected \""$Title"\" by "$Artist"."
			else
				s="    Randomly selected a track by an unlabled artist."
			fi
			App_LOG && App_ECHO
		} #}}}
		Play()
		{ #{{{
			Playcount_0=$Playcount
			Playcount_1=$(expr $Playcount + 1)
			sed -i "s/Playcount='$Playcount_0'/Playcount='$Playcount_1'/" $f_hash
			#Messages
    exec 6<> /dev/pts/4              # Open tty 4 for sending user messages, fd 6
		if [[ $pid != "" ]] then
	    pidLast=$pid; fi
		sox "$Path" -d 2>&6 &
	  pid=$(echo $!)
		sleep "$Length"
		} #}}}
		Replay()
		{ #{{{
			echo
		} #}}}
		Trap_LEGACY()
		{ #{{{
while true; do
	keep_playing=true
	trap 'keep_playing=false' SIGINT
		while $keep_playing ; do
			echo
			ChooseRandom && Play
		done
	Control
done
		} #}}}
while true; do
	ChooseRandom && Play
done
#Trap_LEGACY
  } #}}}
	CONTROL()
		{ #{{{
			Exit()
		{ #{{{
			echo "Exiting WCLI."
			kill $(ps -ef |grep -i "wcli" | grep -w sh | head -n 1 | awk '{print $2}')
			kill $(ps -ef |grep -i "sox" | grep -v grep | head -n 1 | awk '{print $2}')
		} #}}}
			Skip()
		{ #{{{
			kill $(ps -ef |grep -i "wcli" | grep -w sh | head -n 1 | awk '{print $2}')
			kill $(ps -ef |grep -i "sox" | grep -v grep | head -n 1 | awk '{print $2}')
			AIRPLAY&
			break
		} #}}}
			Suppress()
		{ #{{{
			echo "We hate you, "$Title" by "$Artist"!"
		} #}}}
			Controls=("Keep Playing" "Skip" "Suppress" "Exit")
		clear && echo
		PS3="What would you like to do?  "
		select r in "${Controls[@]}" ; do
			case "$REPLY" in
				1) break ;;
				2) Skip ;;
				3) Suppress ;;
				4) Exit ;;
			esac
			break
		done
		exit
		} #}}}
# Exec_wcli.
#
# Run CONTROL if wcli.bash is already running:
	n=$(ps -ef | grep -i "wcli" | grep -iv "grep"| awk '{print $8}' | grep -i "sh")
if [ $(echo $n | wc -w) -ge 3 ] ; then
	CONTROL
else
	SETUP
	AIRPLAY&
fi

} #}}}
Radio_legacy_commands()
{ #{{{  ---  Radio_legacy_commands
	legacy_radiotimer=25
	signoffEcho=""
	signoffEspeak=""
	#tmuxpane_messages=$(tmux list-panes -a -F '#{pane_tty}' | awk '{ print $0 }' | head -n 4 | tail -n 1)  # taboret will handle messages.
	tmuxpane_songstatus=$(tmux list-panes -a -F '#{pane_tty}' | awk '{ print $0 }' | head -n 3 | tail -n 1)

} #}}}
Format_experimental_0()
{ #{{{  ---  Format_experimental_0()
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
	Format&
	exit

} #}}}
TestCommands()
{ #{{{
#artistARRAY=($(ls -d $dir_music/*/ | sed 's/\/// ; s/ //g ; s/.$//'))	
#albumARRAY=($(ls -d $dir_music/$art/* | sed 's/\/// ; s/ //g ; s/.$//'))	

# The be-all end-all array for this task:
#musicARRAY=($(ls -d /$dir_music/*/* | sed 's/\/// ; s/ //g'))	


echo $n
#echo ${music[@]}
#echo ${music[3]}
echo $count_all
echo 
exit
	  s="  Counting albums..." && App_ECHO
albums_count=$(printf "%s\n" "${musicARRAY[@]%/*/*}" | wc -w)
artists_count=$(printf "%s\n" "${musicARRAY[@]%/*}" | uniq | wc -w)
artists_paths=$(printf "%s\n" "${musicARRAY[@]%/*}" | uniq)
random_artist=$(seq $artists_count | shuf | head -1) && nr=$random_artist 
number=$nr && n=84
artist_path=$(printf "%s\n" "${musicARRAY[$n]%/*}" | uniq)
album_count=$(ls "$artist_path" | wc -l)
artist_dir=$(printf "%s\n" "${musicARRAY[$n]%/*}" | uniq | awk -F/ '{print $(NF-0)}')  # Use soxi instead.

#albums_by=$(printf "%s\n" "${musicARRAY[@]%/TAS/*}" | awk -F/ '{print $(NF-0)}')
albums_by=$(printf "%s\n" "${musicARRAY[@]}" | grep $artist_path | sed 's/ /\n/')
#echo $albums_by
#exit


#artist_index=$(printf "%s\n" "${musicARRAY[@]%/*}" | grep -i $artist_dir)
#$(echo shuf)
#n1=$n
#n2=$(expr $n - 1 + $album_count)
#albums_path=$(echo ${musicARRAY[$n,$n2]})
albums_paths=$(printf "%s\n" "$(tree -if "$artist_path")")
albums_all=$(printf "%s\n" "${musicARRAY[@]}")

echo "Total albums count:  $albums_count"
echo "Total artist count:  $artists_count "
sleep 1
#echo "Album paths for $artist_dir:  $albums_by"
#exit
#echo -e "List of artists: \n$artists_paths" | less
sleep .5 && echo 
sleep .5 && echo "Artist path:  $artist_path "
echo "Artist number:  $n "
echo "Artist dir:  $artist_dir "
echo "Album count for $artist_dir:  $album_count"
#echo "Albums by $artist_dir:  $albums_by"
#echo "Album numbers:  $n1,$n2"
sleep 1
#echo "Albums path:  $(echo $albums_paths)"
echo -e "Albums by $artist_dir:\n$albums_by"

#for i in $(seq $n1 $n2) ; do
#	echo "${musicARRAY[$i]}"
#done


#	n=$(echo ${musicARRAY[@]} | ???? | wc -w)  # Artist count.
#echo "${musicARRAY[@]}"


exit
	n=$(echo ${artistARRAY[@]} | wc -w)  # Artist count.
	nr=$(seq $n | shuf | head -1) # random number sequenced from artist count.
	echo "number of artists: $n"
	echo "random number: $nr"
	echo "Random artist: ${artistARRAY[$nr]}"
	echo when asked to echo artistARRAY:  $artistARRAY
	#n_artist=$(echo $artistARRAY) && echo "Artist:  $n_artist"  #pretty useless
	echo ${artistARRAY[@]} | awk '{print $2}' # redundant, but sub numbers to choose.


} #}}}
   #
   ###  PROGRAM EXECUTION
   #
App_RUN
TestCommands
    echo "$song" >> play_count.log

Format()
{ #{{{  ----- Format
	#
	# SEE BashCaseRadioFormat*.txt
[[ -a $f1 ]] && rm $f1                        # Reset playlist.spool
	# Reset ignore list, if day old
ignoreDate=$(stat --format=%w $f2 | head -c 10 | tail -c 2)
[[ -a $f2 ]] && if [ "$(date +%d)" != "$ignoreDate" ] ; then rm $f2 ; fi
	# Find format based on current time
FormatOld=$Format && d="$(date +%H%M)"
. $fF                                         # source format.conf
if [ $Format = "" ] ; then wclisignoff ; else
	[[ $FormatOld != $Format ]] && [[ -s $f1 ]] && rm $f1
	if [[ -s $f1 ]]; then
		BLOCKcallsign
		BLOCKplay
	else
		wcliqueue
		BLOCKcallsign
		BLOCKplay
	fi
fi

} #}}}
wcliqueue()
{ #{{{ ----- wcliqueue
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
	artistARRAY=($(ls -d $dir_music/*/ | sed 's/\/// ; s/ //g')) 				# Critical step
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
wcliqueue_0()
{ #{{{ wcliqueue
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
wclisignoff()
{ #{{{ ----- wclisignoff
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
	runtime="$legacy_radiotimer minute"
	endtime=$(date -ud "$runtime" +%s)
	nextSongDelay=2
	l1="lolcat -f -F .03"
#
cd $dir_music
while [[ $(date -u +%s) -le $endtime ]]
do
	if [[ ! -s $fC ]] ; then wcliqueue; fi
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
	legacy_radiotimer=25
	runtime="$legacy_radiotimer minute"
	endtime=$(date -ud "$runtime" +%s)
	nextSongDelay=2
	l1="lolcat -f -F .03"
#
cd $dir_music
while [[ $(date -u +%s) -le $endtime ]]
do
	if [[ ! -s $fC ]] ; then wcliqueue; fi
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
	wclijunction;
elif [[ $(date +%H) < 22 ]] && [ $buzzer >= $(date +%H) ] ;then
	BLOCKalarm;
	wclijunction;
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
	wclijunction

} #}}}
KillAll()
{ #{{{
if [ -z $(ps ax |grep $s| grep -iv grep | head -n 1 | awk '{ print $1 }') ] ; then
	echo "$(date +%a_%m%d%y_%T) Initializing wclid." >&3
	$s&
fi

} #}}}
   #
   ###  ISSUES AND BUGS
	 #
   ###  NOTES
	 #
	 # Tie messages into taboret
	 # song in background
	 # wcli while instance is already running
	 # accesses control
	 #

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
