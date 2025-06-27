# @2025 GPL, by Michael Milk.
#!/bin/bash
# ~/bin/games/dark.bash
###   INIT:
  DIRlib=$HOME/lib/dark && d="$DIRlib" && [ ! -d "$d" ] && mkdir $d
  DIRvar=$HOME/var/dark && d="$DIRvar" && [ ! -d "$d" ] && mkdir $d
###   COMMANDS:
ArraysInit()
{
	LIBadvbs="$DIRlib/advbs.lib" && mapfile -t ARRadvbs < $LIBadvbs
	LIBadjts="$DIRlib/adjts.lib" && mapfile -t ARRadjts < $LIBadjts
	LIBnouns="$DIRlib/nouns.lib" && mapfile -t ARRnouns < $LIBnouns
	LIBprons="$DIRlib/prons.lib" && mapfile -t ARRprons < $LIBprons
	LIBverbs="$DIRlib/verbs.lib" && mapfile -t ARRverbs < $LIBverbs
		#LIBverbs=(run dodge eat drink barf)
		#LIBptverbs=(ran dodged ate drank barfed)

}
Clear()
{
	cmatrix="cmatrix -obcr -u0"
	clear
	$cmatrix&
	sleep .5 && kill $!
	clear

}
LibInit()
{
	s="..."
	 echo "$s" > $DIRlib/init.lib
	s="...?"
	 echo "$s" >> $DIRlib/init.lib
	s="You wretch."
	 echo "$s" >> $DIRlib/init.lib
	s="You grope in the dark."
	 echo "$s" >> $DIRlib/init.lib
	s="There's no place like home."
	 echo "$s" >> $DIRlib/init.lib
	s="There is nothing to fear but Fear itself."
	 echo "$s" >> $DIRlib/init.lib
	s="Clear your mind."
	 echo "$s" >> $DIRlib/init.lib
	s="Day is night, and night is day."
	 echo "$s" >> $DIRlib/init.lib
	s="Who are you, really?"
	 echo "$s" >> $DIRlib/init.lib
	s="It's not up to you."
	 echo "$s" >> $DIRlib/init.lib
	s="Garbage in, garbage out."
	 echo "$s" >> $DIRlib/init.lib

 }
Question()
{
	q="What do you do?"
	echo "$q"
	read r
	if [[ "$r" == "quit" ]] ; then
		exit 
	else
		i=$(printf "$r" | wc -c)
		Clear
		head -$i $DIRlib/init.lib | tail -1
	fi
}
Wake()
{
	LibInit
	clear && Clear
	clear && echo "You awake in the dark." && sleep $(echo $RANDOM | head -c1)
	Question

}
Wake

