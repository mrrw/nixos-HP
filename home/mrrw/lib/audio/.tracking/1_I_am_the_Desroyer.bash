EXP=$DIR.export
FIN=$EXP/TMFdestroyer && [ -d $FIN ] && mkdir $FIN
SRC=$DIR.source
OUT=$SRC/TMFdestroyer && [ -d $OUT ] && mkdir $OUT

SinkingTheLifeboats() { fI="$SRC/TMF-demos_2025/1..ogg" 

	fO="$OUT/SinkingTheLifeboats.ogg"
	if [ ! -s
	sox $fI $fO gain -12 trim 5:18 9:58
	ffmpeg -i
}

EastPalestine23() { 
mv ZOOM/251103-080917.MP3 dismembered_armistice/
f=source/converted/251103-080917.WAV
f2=dismembered_armistice.STEM-drums.wav
sox $f $f2 gain +6 trim 12 3:59
}
