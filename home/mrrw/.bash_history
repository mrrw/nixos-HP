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
gitp
c
audio
cd lib
mv audio_exports/ audio/exports
audio
c
cd
mnix
mgit
mv ZOOM/ .ZOOM
c
init
vim init
cl
audio
mkdir .bin
cp ~/bin/ZOOMcopy.bash .bin/
cp ~/bin/mp32wav.bash .bin/
cd .bin/
cd ..
vim .init
audio
vim .init
c
vim init 
rm init 
vim .init
c
vim .init
c
vim .init
c
mkdir .source
mkdir .tracking
c
clear
vim .init
c
vim ~/.alias
. ~/.alias
c
cmus
audio
vim dismembered_armistice/
init
c
man grep
init
c
cd c
init
init
. ~/.alias
c
man grep
c
man grep
c
mv stalag_softstep/source/ .source/TMF_stalag_softstep
c
ls .source/TMF_stalag_softstep/
mv exports/demo.stalag_softstep.mp3 stalag_softstep.demo.mp3
c
mv stalag_softstep/ exports/
c
ls exports/stalag_softstep/
mv exports/stalag_softstep/ .source/stalag_softstep/
c
cd .source/
ls -a
tree -a
vim stalag_softstep/.instructions 
c
mv TMF_stalag_softstep/ source
c
audio
c
audio
init
audio
alias audio
init
audio
init
c
audio
c
audio
c
mv dismembered_armistice/.instructions .tracking/dismembered_armistice.txt
c
mv stalag_softstep.demo.mp3 exports/
c
mv dismembered_armistice/ .source/dismembered_armistice
c
mv .source/source/ .source/stalag_softstep/
c
alias ls
c
mv .init init
c
audio
mv init .init
c
audio
init
c
vim ~/.bashrc 
vim ~/bin/bash-commons.bash 
q
mgit -i
q
clear
clear
audio
mv .init .init.bash
c
init
c
mv .init.bash .init
c
init
c
init
audio
c
audio
c
audio
c
audio
c
audio
alias audio
bashrc
vim ~/.bashrc 
vim ~/bin/bash-commons.bash 
q
init
q
clear
q
clear
clear
audio
audio
c
audio
c
sudo mount /dev/sdb1 ~/mnt/USB/
cd ~/mnt/USB/STEREO/FOLDER01/
play 170106-212025.WAV 
cp 170106-212025.WAV ~/lib/audio/.ZOOM
init
c
ls .ZOOM/
man mpg123 
cd
sudo umount /dev/sdb1
audio
zoom
Welcome
c
vim .bin/mp32wav.bash 
z
b
t
s
e
a
init
c
info bash function
c
init
vim .init 
q
vim .init
z
audio
z
c
a
audio
a
z
a
audio
a
q
fg
q
clear
q
clear
clear
audio
audio
a
z
a
audio
init
audio
a
az
z
a
z
a
e
c
s
audio
s
a
c
audio
c
a
c
a
c
a
c
z
a
z
a
c
t
a
t
a
s
init
mgit
gitp
sudo cd /
su
cd
git reset
cd /
mgit -i
reboot
clear
git status
gitp
a
audio
z
mgit -i
c
audio
b
init
b
audio
b
mpg123 -w 170106-212025.WAV new.mp3
c
f=170106-212025.WAV 
mpg123 -w new.mp3 #f
mpg123 -w new.mp3 $f
c
mpg123 -w new.mp3 $f
mpg123 -w $f new.mp3
mpg123 -w $f 
ffmpeg -i $f Omnipresence.mp3
c
mv 170106-212025.WAV 170106-212025.WAV_
mv Omnipresence.mp3 ../exports/
a
play exports/Omnipresence.mp3 
mv exports/Omnipresence.mp3 exports/omnipresence.mp3 
c
vim mp32wav.bash 
gitp
cp exports/omnipresence.mp3 .ZOOM/
gitp
z
mv 170106-212025.WAV_ 170106-212025.WAV
gitp
c
a
init
e
mkdir TMF_I_am_the_Destroyer
mv *.mpe TMF_I_am_the_Destroyer/
mv *.mp3 TMF_I_am_the_Destroyer/
c
a
e
cd TMF_I_am_the_Destroyer/
c
..
c
..
c
z
rm omnipresence.mp3 
gitp
c
a
b
a
mgit -i
c
..
c
a
c
a
mkdir .mnt
c
a
c
a
c
a
cd
a
cd
d
s
b
r
vim .init 
a
init
a
s
a
init
c
cd
c
a
audio
a
s
cd
a
cd
c
a
init
audio
b
a
:w
