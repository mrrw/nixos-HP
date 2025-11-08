projectname=$TMF_IAmTheDestroyer
EXP=$DIR.export
FIN=$EXP/$projectname && [ -d $FIN ] && mkdir $FIN
SRC=$DIR.source
OUT=$SRC/$projectname && [ -d $OUT ] && mkdir $OUT

SinkingTheLifeboats() { name=SinkingTheLifeboats
	fI="$SRC/TMF-demos_2025/1..ogg" 
	fO="$OUT/$name.ogg
	fE="EXP
	if [ ! -s $fO ] ; then
		sox $fI $fO gain -12 trim 5:18 9:58
	fi
	ffmpeg -i
}

EastPalestine23() { 
mv ZOOM/251103-080917.MP3 dismembered_armistice/
f=source/converted/251103-080917.WAV
f2=dismembered_armistice.STEM-drums.wav
sox $f $f2 gain +6 trim 12 3:59
}
