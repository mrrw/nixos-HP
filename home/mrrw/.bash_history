sox -m track1.wav 251102-084942_compressed.WAV -d gain -6
sox 251030-073053.WAV track1.wav trim 14.5
sox -m track1.wav 251102-084942_compressed.WAV -d gain -6
sox 251030-073053.WAV track1.wav trim 13.5
sox -m track1.wav 251102-084942_compressed.WAV -d gain -6
sox 251030-073053.WAV track1.wav trim 13.4
sox -m track1.wav 251102-084942_compressed.WAV -d gain -6
sox 251030-073053.WAV track1.wav trim 13.45
sox -m track1.wav 251102-084942_compressed.WAV -d gain -6
sox 251030-073053.WAV track1.wav trim 13.4
sox -m track1.wav 251102-084942_compressed.WAV -d gain -6
sox 251030-073053.WAV track1.wav trim 13.3
sox -m track1.wav 251102-084942_compressed.WAV -d gain -6
sox 251030-073053.WAV track1.wav trim 13.5
sox -m track1.wav 251102-084942_compressed.WAV -d gain -6
sox 251030-073053.WAV track1.wav trim 13.6
sox -m track1.wav 251102-084942_compressed.WAV -d gain -6
w3m
man sox
sox track1.wav -d
c
cd ..
cd ZOOM/
mkdir stallags
w3m
c
mv stallags/ stalag_softstep
c
mv stalag_softstep/ ../
c
cd //
w3m
reboot
clear
tree lib/audio/
cd lib/audio/
mv ZOOM/* stalag_softstep/
c
cd stalag_softstep/
mkdir SOURCE
mv *.MP3 SOURCE/
c
mv WAV/ CONVERSION/
c
mv CONVERSION/track1.wav ./
c
mv CONVERSION/251102-084942_compressed.WAV ./track2.wav
c
cp track2.wav CONVERSION/251102-084942_compressed.MP3
c
rm CONVERSION/251102-084942_compressed.MP3 
cp track2.wav 251102-084942_compressed.WAV
c
mv 251102-084942_compressed.WAV CONVERSION/
c
mv track1.wav t1_drums.raw.wav
mv t2_keys.raw.wav
mv track2.wav t2_keys.raw.wav
c
mv CONVERSION/ SOURCE/
c
mkdir TRACKS
mv t* TRACKS/
c
mv TRACKS/* ./
c
rmdir TRACKS/
c
cd lib/audio/
cd stalag_softstep/
sox t1_drums.raw.wav -d
sox t1_drums.raw.wav -d remix 1 0
sox t1_drums.raw.wav -d remix 0 2
sox t1_drums.raw.wav t1_drums.RIGHT.wav remix 0 2
sox t1_drums.raw.wav t1_drums.LEFT.wav remix 1 0
sox -m t1_drums.LEFT.wav t1_drums.RIGHT.wav -d
sox t1_drums.LEFT.wav gain -12
sox t1_drums.LEFT.wav -d gain -12
sox t1_drums.LEFT.wav t1_drums.LEFT-SOFT.wav gain -12
C
c
sox t1_d-m rums.LEFT-SOFT.wav t1_drums.RIGHT.wav -d
sox -m t1_drums.LEFT-SOFT.wav t1_drums.RIGHT.wav -d
c
sox -m t1_drums.LEFT-SOFT.wav t1_drums.RIGHT.wav t2_keys.raw.wav -d
c
sox t2_keys.raw.wav t2_keys.SOFT.wav gain -6
sox -m t1_drums.LEFT-SOFT.wav t1_drums.RIGHT.wav t2_keys.SOFT.wav -d
sox t2_keys.SOFT.wav bass +12 trim 4:30
sox t2_keys.SOFT.wav -d bass +12 trim 4:30
sox t2_keys.SOFT.wav -d bass +12
sox t2_keys.SOFT.wav -d bass +12 gain -6
sox t2_keys.SOFT.wav t2_keys.SOFT-BASS.wav bass +12 gain -6
c
sox -m t1_drums.LEFT-SOFT.wav t1_drums.RIGHT.wav t2_keys.SOFT-BASS.wav -d
sox -m t1_drums.LEFT-SOFT.wav t1_drums.RIGHT.wav t2_keys.SOFT-BASS.wav demo.wav
c
play demo.wav 
mv demo.wav demo.stalag_softstep.wav
c
man sox
c
cd
mkdir lib/audio_exports
cp demo.stalag_softstep.wav ~/lib/audio_exports/
cd
gitp
c
cd lib/audio_exports/
ffmpeg -i demo.stalag_softstep.wav -af aformat+s16:44100 demo.stalag_softstep.mp3
c
vim bin/mp32wav.bash 
c
ffmpeg demo.stalag_softstep.wav demo.stalag_softstep.wmp3
c
play *
f="demo.stalag_softstep"
ffmpeg $f.wav $f.mp3
ffmpeg -i $f.wav $f.mp3
ls -l
man ffmpeg 
play demo.stalag_softstep.mp3 
c
cd lib/audio/
ls -l
tree -l
c
rm $f.wav
c
cd
gitp
c
audio
vim .alias
. .alias
audio
cd ..
cd audio/
cd stalag_softstep/
f1=t1_drums.raw.wav 
f2=stem-drums.stalag_softstep.mp3
ffmpeg -i $f1 $f2
c
mv stem-drums.stalag_softstep.mp3 ../../audio_exports/
cd
gitp
c
cd
audio
. .alias
audio
cd
cd
gitp
c
audio
cd
chores 
cd
cal
cal -1
cal -3
cal -2
cal -S
cal -s
cal -m
c
cal -v
cal -y
c
cal -Y
c
cal -w
cal -w 45
c
cal -w 45
c
cal -w 1
c
cal --color
c
cal -c
cal -c=1
cal --columns=1
c
cal -v
cal -v > test.txt
vim test.txt 
cal -v
cal -v | grep 9
cal -v | grep 10
cal --color=auto
cal --color=always
cal --help
echo -e 'weekend 35\ntoday 1;41\nheader yellow'
echo -e 'weekend 35\ntoday 1;41\nheader yellow' > $HOME/.config/erminal-colors.d/cal.scheme
man mkdir
mkdir -p .config/terminal-colors.d/
echo -e 'weekend 35\ntoday 1;41\nheader yellow' > $HOME/.config/erminal-colors.d/cal.scheme
echo -e 'weekend 35\ntoday 1;41\nheader yellow' > test2.txt
cat test2.txt > $HOME/.config/terminal-colors.d/cal.scheme
cal
cal > test3.txt
cat test3.txt 
cal -v
cal
cal -3
c
vim test2.txt 
rm test2.txt 
vim test3.txt 
rm test3.txt 
vim test.txt 
c
cal -v
date
date +%d
man cal
man date
vim .config/neofetch/
neofetch
mkdir .config/neofetch/image
neofetch
echo butts > .config/neofetch/image/test.txt
neofetch
ls .config/neofetch/
ls .config/neofetch/image/
man neofetch
neofecth
neofetch 
neofetch
alias neofetch
neofetch
neofetch
/neofetch
\neofetch
vim test.txt 
\neofetch
neofetch
vim test.txt 
vim .config/neofetch/config.conf 
rmdir .config/neofetch/image/
man rmdir
cd .config/neofetch/
rm image/test.txt 
rmdir image/
mv ../../test.txt ./image
neofetch
\neofetch
vim config.conf 
cal
cal --color=never
cal -v
cal -v --color=never
c
date +%u
date +%a
date +%a | head -c 2
man date
vim calNeofetchImage.bash
chmod +x calNeofetchImage.bash 
bash calNeofetchImage.bash 
vim calNeofetchImage.bash 
bash calNeofetchImage.bash 
vim calNeofetchImage.bash 
bash calNeofetchImage.bash 
vim calNeofetchImage.bash 
bash calNeofetchImage.bash 
vim calNeofetchImage.bash 
bash calNeofetchImage.bash 
vim calNeofetchImage.bash 
bash calNeofetchImage.bash 
vim calNeofetchImage.bash 
bash calNeofetchImage.bash 
cd
ls
vim calNeofetchImage.bash > test.txt
bash calNeofetchImage.bash > test.txt
vim test.txt 
bash calNeofetchImage.bash 
gitp
c
bash calNeofetchImage.bash 
c
bash calNeofetchImage.bash 
c
bash calNeofetchImage.bash 
vim test.txt 
dayNumber=$(date +%u)
echo $dayNumber | wc -c
echo $dayNumber 
dayNumber=30
echo $dayNumber | wc -c
info bash if
man date
cal -c
cal --columns=3
cal --columns=1
cal --columns=10
c
cal tomorrow
cal August
man cal
c
date
echo -e "   $(date +%b%y)"
echo -e "$(date +%y  %b)"
echo -e "$(date +%y  +%b)"
echo -e "$(date +%y%b)"
echo -e "$(date +%y)  $(date +%b)"
echo -e "$(date +%y)  $(date +%b)  $(date next month)"
echo -e "$(date +%y)  $(date +%b)  $(date next Month)"
echo -e "$(date +%y)  $(date +%b)  $(date next +%b)"
echo -e "$(date +%y)  $(date +%b)  $(date --date next +%b)"
echo -e "$(date +%y)  $(date +%b)  $(date --date next month +%b)"
echo -e "$(date +%y)  $(date +%b)  $(date --date='next month +%b)"

pl
date +%_b
date +%__b
date +%y__%b
date +%y  %b
date +%y--$b
date +%y--%b
date +%y00%b
date +%y__%b
date +%#y__%b
date +%y__%#b
date +%y__%b
vim calNeofetchImage.bash 
c
pl
c
date +%G
date +%G%j
date --date="2025308"
date --date="3082025"
date --date="@3082025"
man date
date +%F
date --date="2025-11-04"
date -v
cal -v
info date
cal -v
bash calNeofetchImage.bash 
cal -v3
date +%G
date +%G__%j
date +%G__%m
date +%G__%M
date +%G__%b
man date
bash calNeofetchImage.bash 
c
bash calNeofetchImage.bash 
info bash array
info bash list
/info bash for
info bash for
bash calNeofetchImage.bash 
bash calNeofetchImage.bash > test.txt
vim test.txt 
bash calNeofetchImage.bash 
w3m
c
bash calNeofetchImage.bash 
c
bash calNeofetchImage.bash 
gitp
c
bash calNeofetchImage.bash 
man date
w3m
c
date
date tomorrow
date -d
date -d '+1 day'
date -d '+14 day'
w3m
date -d '+14 day' +%d
bash calNeofetchImage.bash 
vim calNeofetchImage.bash 
gitp
c
man date
pl
c
c
w3m
c
gitp
c
mv calNeofetchImage.bash bin/
c
rm test.txt 
c
sudo mount /dev/sdb1 ~/mnt/USB/
cd mnt/USB/STEREO/FOLDER01/
play 251103-102208.MP3 
play 251103-080917.MP3 
cp 251103-080917.MP3 ~/lib/audio/ZOOM/
cd
sudo umount /dev/sdb1
audio
mkdir dismembered_armistice
mv ZOOM/251103-080917.MP3 dismembered_armistice/
c
mkdir dismembered_armistice/SOURCE dismembered_armistice/CONVERTED
C
c
mv dismembered_armistice/CONVERTED/ dismembered_armistice/SOURCE/
c
cd dismembered_armistice/
mv 251103-080917.MP3 SOURCE/
c
mv SOURCE/ source
mv source/CONVERTED/ source/converted
c
cd source/
mpg123 -w converted/251103-080917.WAV 251103-080917.MP3 
c
cd ..
sox source/converted/251103-080917.WAV  -d
sox source/converted/251103-080917.WAV  -d gain +12
sox source/converted/251103-080917.WAV  -d gain +6 trim 12
f=source/converted/251103-080917.WAV 
sox $f -d gain +6 trim 12
vim bin/mp32wav.bash 
c
sox $f -d gain +6 trim 12 3:59
c
f2=dismembered_ar
f2=dismembered_armistice.STEM-drums.wav
sox $f $f2 gain +6 trim 12 3:59
c
vim audio
c
audio
C
c
play dismembered_armistice.STEM-drums.wav 
cd
vim .bash_history 
cat .bash_history | grep stalag
cat .bash_history | grep t1
cd stalag_softstep/
mv SOURCE/ source
mv source/CONVERSION/ source/conversion
c
cat .bash_history | grep t1 >> .instructions
cat .bash_history | grep t2
cat .bash_history | grep t2 >> .instructions 
cat .bash_history | grep stalag
cat .bash_history | grep stalag >> .instructions 
mv .instructions lib/audio/stalag_softstep/
less .instructions 
c
..
c
cat .bash_history | grep dismembered
cat .bash_history | grep dismembered > .instructions
cat .bash_history | grep STEM
cat .bash_history | grep f2
cat .bash_history | grep f2 | tail -1
cat .bash_history | grep f2 | tail -2
cat .bash_history | grep f2 | tail -4 | head -1 >> .instructions 
cat .instructions 
cat .bash_history | grep f1
cat .bash_history | grep f1 >> .instructions 
cat .instructions 
CD
cd
vim .instructions 
mv lib/audio/dismembered_armistice/
mv .instructions lib/audio/dismembered_armistice/
c
vim .bash_history 
c
gitp
c
man bash
man mktemp 
c
w3m
c
tmux resize-pane -t 2 -U 2
tmux resize-pane -t 2 -U 6
vim .config/tmux/initcommands.conf 
q
q
q
clear
clear
vim .config/tmux/initcommands.conf 
q
q
clear
q
clear
clear
gitp
c
c
farm
cd lists/
ls -a
cat .crops/barley 
w3m
c
w3m
c
cd
farm
cat 2026/cropList.txt | grep Nov
cat 2026/cropList.txt | grep Oct
song
cd The_Crashing_Through/
vim setlist.txt
c
cat setlist.txt 
vim .init
c
vim .init
v
c
song
cd The_Crashing_Through/
vim .init 
c
vim setlist.txt 
c
cd
gitp
c
gitp
c
song
vim SONG--ThingsMoveOn.txt 
bash info select
vim .init
c
vim .init
c
vim .init
c
info bash select
. cd TMF
w3m
man pushd
pushd
pushd TMF/
ls
popd
vim .init
c
vim .init
c
vim .init
c
ls The_Crashing_Through/
c
vim The_Crashing_Through/
cd The_Crashing_Through/
w3m
c
vim SONG--ThingsMoveOn.txt 
cd
