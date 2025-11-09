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
		sox $fI $fO gain +6 trim 12 3:59
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
		ffmpeg -i $fI $fO
	fi
	if [ ! -s $fO ] ; then
		## Fix 4:40 extra beat  
		## Fix 6:10 needs two china hits before the '1'
		sox $fI $fO trim 10 7:38 fade 0 0 3
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
		sox $fI $fO gain -12 trim 5 8:27 fade 1 remix - gain -3
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
		sox -m $fI1 $fI2 $fO gain +6 trim 12 3:59
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
		sox $fI $fO gain -12 bass +12 trim 5:18 9:58
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
		sox $fI $fO gain -12 trim 21:40 4:30 fade 10 0 10
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
		sox $fI $fO gain -12 trim 44 4:40
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
		sox $fI $fO gain -6 #trim 44 4:40
	fi
	if [ ! -s $fE ] ; then
		ffmpeg -i $fO -acodec libmp3lame $fE
	fi
}

NewDiaspora ## trim again
Terraformer ## trim again?
StalagSoftstep
EastPalestine23
Omnipresence
SweetScheudenfrad ## needs trimming
StarlinkDown ## fix the trimming
TheScrapingOfPotsherds
SinkingTheLifeboats ## needs +bass
