projectname=TMF_IAmTheDestroyer
EXP=$DIR.exports
END="$EXP/$projectname" && [ ! -d $END ] && mkdir -p "$END"
SRC=$DIR.source
OUT="$SRC/$projectname" && [ ! -d $OUT ] && mkdir -p "$OUT"

StalagSoftstep() { name=StalagSoftstep
	fI1=$SRC/ZOOM/251030-073053.WAV
	fI2=$SRC/ZOOM/251102-084942.WAV
	fO="$OUT/$name.wav"
	fE="$END/$name.mp3"
	if [ ! -s $fO ] ; then
		sox -m $fI1 $fI2 $fO gain +6 trim 12 3:59
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}
EastPalestine23() { name=EastPalestine23
	fI=$SRC/ZOOM/251103-080917.WAV
	fO="$OUT/$name.wav"
	fE="$END/$name.mp3"
	if [ ! -s $fO ] ; then
		sox $fI $fO gain +6 trim 12 3:59
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}
NewDiaspora() { name=NewDiaspora
	fI=$SRC/ZOOM/251105-015456.MP3
	fO="$END/$name.mp3"
	if [ ! -s $fO ] ; then
		## Fix 4:40 extra beat  
		## Fix 6:10 needs two china hits before the '1'
		sox $fI $fO trim 10 7:38 fade 0 0 3
	fi

Omnipresence() { name=Omnipresence
	fI="$SRC/ZOOM/170106-212025.WAV"
	fO="$OUT/$name.wav"
	fE="$END/$name.mp3"
	if [ ! -s $fO ] ; then
		sox $fI $fO gain -12 trim 5 8:27 fade 1 remix - gain -3
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}

SinkingTheLifeboats() { name=SinkingTheLifeboats
	fI="$SRC/TMF-demos_2025/1..ogg" 
	fO="$OUT/$name.ogg"
	fE="$END/$name.mp3"
	if [ ! -s $fO ] ; then
		sox $fI $fO gain -12 trim 5:18 9:58
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}

Terraformer() { name=Terraformer
	fI="$SRC/TMF-demos_2025/1..ogg" 
	fO="$OUT/$name.ogg"
	fE="$END/$name.mp3"
	if [ ! -s $fO ] ; then
		sox $fI $fO gain -12 trim 44 4:40
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}


EastPalestine23
Omnipresence
SinkingTheLifeboats
Terraformer
