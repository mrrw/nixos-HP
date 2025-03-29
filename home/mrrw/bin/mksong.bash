#!/bin/bash
# ~/bin/makesong.bash
# ...by mrrw, @2024, no rights reserved
# Fast and minimal sox-based DAW for the terminal.  Copies and splices raw
# audio into a new and final product using a menu-based terminal interface.
# set -x  ##  debug mode
#
###   INITIAL COMMANDS:
nameApp=mksong && n=$nameApp
dirLog=$HOME/var/log && d=$dirLog && [ ! -d $d ] && mkdir -p $d
dirMain=$HOME/usr/$n && d=$dirMain && [ ! -d $d ] && mkdir -p $d
dirTmp=$HOME/var/$n && d=$dirTmp && [ ! -d $d ] && mkdir -p $d
options="hx"

Help()
{
	echo ""
	echo "   USAGE:  mksong [-$options] "
	echo ""
	echo "   DESCRIPTION:  Fast and minimal sox-based DAW for the terminal."
	echo "      Copies, splices, & mixes raw audio into a new product using"
	echo "      a menu-based terminal interface."
	echo ""
	echo "   OPTIONS:"
	echo "     -h, --help       |  Display this help."    
	echo "     -x, --debug      |  Run program in debug mode."    
	echo ""
}

###   OPTIONS:
while getopts ":$options" opt; do
	case ${opt} in
		h | --help)
			Help ;
			exit ;;
		x | --debug)
			set -x ;
			shift ;
			;;
		*)
			echo "Invalid option: -${OPTARG}."
			exit 1 ;;
	esac
done


###   SOURCING
#dirSources=$dirMain/.sources && d=$dirSources && [ ! -d $d ] && mkdir -p $d
#
# PRELIMINARY NOTES:
# 
# File structure dictates usage.
# Every non-directory, non-hidden file in dirMain should be a wav/mp3/whatever.
# These sound files will be the raw files that any given song can access
# to build itself.  Each directory in dirMain is a seperate song.
# Contained in each song directory is a set of instructions for cutting and
# splicing samples of source sounds into a new piece of music, which can
# simply be played back or can be exported into a new mp3/wav/whatever.
# Hidden directories are sound-making modules.
# Hidden files contained in dirMain are .conf files.
# Logs and temp files are directed to ~/var by default.

###   BUILD COMMANDS:
menuMain()
{
	d=$dirMain && cd $d
	#echo -e "What would you like to do?\n"
	while IFS= read -r line ; do
		options+=("$line")
	done < .menuMain
	PS3="What would you like to do now?"
	select option in "${options[@]}" ; do
		case $option in 
			"$(head -n 1 .menuMain)") songPlay ;;
			"$(head -n 2 .menuMain | tail -n 1)") songBuild ;;
			"$(head -n 3 .menuMain | tail -n 1)") soundBuild ;;
			"$(head -n 4 .menuMain | tail -n 1)") soundRecord ;;
			"$(head -n 5 .menuMain | tail -n 1)") soundPlay ;;
			"$(head -n 6 .menuMain | tail -n 1)") configureApp ;;
			"$(head -n 7 .menuMain | tail -n 1)") echo "coconutz" ;;
			"$(head -n 8 .menuMain | tail -n 1)") echo "cocobutts" ;;
			*) echo "invalid option"
		esac
	done
}
menuSong()
{
	d=$dirMain && cd $d
	echo "Choose a song to work on:"
	find . -maxdepth 1 -type f

}
songBuild()
{
	menuSong
}
songPlay()
{
	menuSong
}
soundBuild()
{
	menuSound
}
soundRecord()
{
	ftmp=$dirTmp/tmp.wav
	sox -d tmp.wav
	clear && echo "Done!  If you want to delete this take, press [d]."
	read r && if [ $r != "d" ] ; then
		echo "What would you like to name this sound?  (We'll add the .wav at the end)"
		read r
		fnew=$dirMain/$r && mv $ftmp $fnew
	fi
	rm $ftmp
}
soundPlay()
{
	menuSound
}
you_are_here()
{
	d=$dirMain && cd $d
	clear && pwd && tree -aL 2 | sed '$d'

}
you_were_there()
{
	d=$dirMain && cd $d
	clear && ls .. && echo && pwd && tree -L 2

}


# OLD COMMANDS:

mkIntro()
{
# INTRO WILL NEED SPECIAL ATTENTION AND MULTIPLE SPLICES WITH effects
cd $dirMain/$nameSong/parts
	#sox $f parts/intro.wav trim 43 # end time 3:00 # approximate start with reverb, end with reverse verb/flanger
	sox $f tmp2.wav trim 43 3 reverb -w 80 80 80 80 0 6 
	sox $f tmp2.wav trim 46 4.9  reverb 80 80 80 80 0 6 
	sox $f tmp3.wav trim 51 5  reverse reverb 80 80 80 80 0 6 reverse 
	sox $f tmp4.wav trim 56 4  reverse reverb 50 50 50 50 0 6 reverse 
	sox $f tmp5.wav trim 1:00 16.3 # end time 1:16
		sox tmp1.wav tmp2.wav tmp3.wav tmp4.wav tmp5.wav introDry.wav splice .5 .5 reverb 80 80 80 80 0 6
	rm tmp1.wav tmp2.wav tmp3.wav tmp4.wav tmp5.wav
		sox introDry.wav introWet.wav reverb -w tremolo 10 30 overdrive gain -6
		sox -m introDry.wav introWet.wav introBoth.wav

}
	#sox $f tmp2.wav trim 1:21 30 reverb flanger # end time 2:21
mkBody ()
{
sox $f parts/main1.wav trim 3:34 38 #approximate. # end time 4:12
sox $f parts/break.wav trim 14.9 48 # end time . # Start with lots of spotty reverb
sox $f parts/main2.wav trim 3:34 38 #approximate.  # end time 4:12
sox $f parts/break.wav trim 11.69 6.5 # end time 18.2
sox $f parts/break.wav trim 14.9 30 # approximate.  # end time 46?
sox $f parts/break.wav trim 5.5 7
sox $f parts/mainfinal.wav trim 5:16 #approximate.  end time 7:29
sox $f parts/tag.wav trim 7:59.1
sox $f parts/bridge.wav
sox $infile parts/a.wav trim 00:15.300 19
sox $infile parts/b.wav trim 00:43.000 37.3
	sox parts/a.wav parts/b.wav out.wav splice 19,3
}

mkSong1 ()
{
# SONG VARIABLES:
	nameSong=song1
# SONG DIRECTORIES:
	dirSong=$dirMain/$nameSong && d=$dirSong && [ ! -d $d ] && mkdir -p $d && cd $d
	d="" && [ ! -d $d ] && mkdir -p $d && cd $d
	cd $d && ! -d $songname && mkdir $songname
	
	f=~/usr/mksong/convertedSource.wav 
	mkIntnro

#sox $f tmp.wav reverse reverb 50 10 100 100 100 trim 42 35 fade p .1 && sox tmp.wav /$songname/intro.wav reverse fade p 5
#sox $f parts/bridge.wav trim 14.17 30 # approximate.  end time 13:49 ish
#sox $f parts/tag.wav reverse trim 9.09 30 # approximate.  end time 
}

mkSong2 ()
{
	songname=song2
	f=~/usr/mksong/convertedSource.wav 
	cd ~/usr/mksong
	! -d $songname && mkdir $songname
sox $f tmp.wav reverse reverb 50 10 100 100 100 trim 42 35 fade p .1 && sox tmp.wav /$songname/intro.wav reverse fade p 5
sox $f parts/bridge.wav trim 14.17 30 # approximate.  end time 13:49 ish
sox $f parts/tag.wav reverse trim 9.09 30 # approximate.  end time 
}

playSong()
{
	sox $d/* -d

}
#mkIntro
#mkBody
#Play

# EXECUTE:
you_are_here
menuMain
