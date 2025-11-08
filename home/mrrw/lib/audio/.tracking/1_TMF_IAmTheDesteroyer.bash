projectname=TMF_IAmTheDestroyer
EXP=$DIR.exports
END="$EXP/$projectname" && [ ! -d $END ] && mkdir -p "$END"
SRC=$DIR.source
OUT="$SRC/$projectname" && [ ! -d $OUT ] && mkdir -p "$OUT"

EastPalestine23() { name=EastPalestine23
	fI=$SRC/ZOOM/251103-080917.MP3
	fE="$END/$name.mp3"
	if [ ! -s $fO ] ; then
		sox $fI $fO gain +6 trim 12 3:59
	fi
}

SinkingTheLifeboats() { name=SinkingTheLifeboats
	fI="$SRC/TMF-demos_2025/1..ogg" 
	fO="$OUT/$name.ogg"
	fE="$END/$name.mp3"
	if [ ! -s $fO ] ; then
		sox $fI $fO gain -12 trim 5:18 9:58
	fi
	sleep 2
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
SinkingTheLifeboats
Terraformer
