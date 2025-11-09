projectname=TMF_IAmTheDestroyer
EXP=$DIR.exports
END="$EXP/$projectname" && [ ! -d $END ] && mkdir -p "$END"
SRC=$DIR.source
OUT="$SRC/$projectname" && [ ! -d $OUT ] && mkdir -p "$OUT"
x=0

EastPalestine23() { name=EastPalestine23
	x=$((x+1))
	fI=$SRC/ZOOM/251103-080917.WAV
	fO="$OUT/$name.wav"
	fE="$END/$x.$name.mp3"
	if [ ! -s $fO ] ; then
		#sox $fI $fO trim 12 3:59 ## includes count-in
		sox $fI $fO trim 6 4:05 fade 0 0 2 ## discludes count-in
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}
NewDiaspora() { name=NewDiaspora
	x=$((x+1))
	fI=$SRC/ZOOM/251105-015456.MP3
	ffmpeg -i $fI $fI.wav
	fO="$OUT/$name.wav"
	fE="$END/$x.$name.mp3"
	if [ ! -s $fO ] ; then
		## Fix 4:40 extra beat  
		## Fix 6:10 needs two china hits before the '1'
		sox $fI.wav $fO trim 10 7:38 fade 0 0 3
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}
Omnipresence() { name=Omnipresence
	x=$((x+1))
	fI="$SRC/ZOOM/170106-212025.WAV"
	fO="$OUT/$name.wav"
	fE="$END/$x.$name.mp3"
	if [ ! -s $fO ] ; then
		sox $fI $fO gain -12 trim 5 8:27 fade 3 remix - gain -3
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}
StalagSoftstep() { name=StalagSoftstep
	x=$((x+1))
	fI1=$SRC/ZOOM/251030-073053.WAV
	fI2=$SRC/ZOOM/251102-084942.WAV
	fO="$OUT/$name.wav"
	fE="$END/$x.$name.mp3"
	if [ ! -s $fO ] ; then
		sox -m $fI1 $fI2 $fO gain +6 trim 12 3:47
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}
SinkingTheLifeboats() { name=SinkingTheLifeboats
	x=$((x+1))
	fI="$SRC/TMF-demos_2025/1..ogg" 
	fO="$OUT/$name.ogg"
	fE="$END/$x.$name.mp3"
	if [ ! -s $fO ] ; then
		sox $fI $fO gain -12 bass +12 trim 5:14 10:02 fade 5 0 0
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}
StarlinkDown() { name=StarlinkDown
	x=$((x+1))
	fI="$SRC/TMF-demos_2025/1..ogg" 
	fO="$OUT/$name.ogg"
	fE="$END/$x.$name.mp3"
	if [ ! -s $fO ] ; then
		#trim -33:XX
		sox $fI $fO gain -12 trim 30:47 4:38
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}
SweetScheudenfrad() { name=SweetScheudenfrad
	x=$((x+1))
	fI="$SRC/TMF-demos_2025/1..ogg" 
	fO="$OUT/$name.ogg"
	fE="$END/$x.$name.mp3"
	if [ ! -s $fO ] ; then
		#trim  21:40? 26:XX?
		#long fade beginning, even longer fade end
		#sox $fI $fO gain -12 trim 21:40 4:30 fade 10 0 10
		sox $fI $fO gain -12 trim 21:40 3:54 fade 10
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}
Terraformer() { name=Terraformer
	x=$((x+1))
	fI="$SRC/TMF-demos_2025/1..ogg" 
	fO="$OUT/$name.ogg"
	fE="$END/$x.$name.mp3"
	if [ ! -s $fO ] ; then
		sox $fI $fO gain -12 trim 44 3:26
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}
TheScrapingOfPotsherds() { name=TheScrapingOfPotsherds
	x=$((x+1))
	fI="$SRC/ZOOM/231123-165249.WAV"
	fO="$OUT/$name.wav"
	fE="$END/$x.$name.mp3"
	if [ ! -s $fO ] ; then
		sox $fI $fO gain -6 fade 0 0 3
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}

NewDiaspora ## Needs band development
StalagSoftstep ## Needs work, but not for demo
Terraformer ## trim again.
EastPalestine23
Omnipresence
SweetScheudenfrad ## Sharp stop options?
StarlinkDown ## sounds good preceded by SweetScheudenfrad, sharp transition
TheScrapingOfPotsherds ## fade out
SinkingTheLifeboats ## fade in
