#!/bin/bash
# Generate and cocatenate musical sound into direct output and files.
#
# musicmaker.bash, copyleft 2025 under GNU Public License.
#	By Michael Robert Milk.
#	AI was not utilized in the creation or modification of this document.
set -e

# Core commands:
# play -n -c1 $sound  --  -n = null file, -c1 = 1 channel.  Both kinda required.
# sox $file -d  --  $file = file to play.  -d = direct output device (speakers).
# sox -d $file  --  -d = direct input device.  $file = file on which to record.
# When playing synths, best to add gain and fade to prevent clipping and madness.

examplesMansox()
{ #{{{
play -n -c1 synth sin %-12 sin %-9 sin %-5 sin %2 fade h 0.1 1 0.1 &> /dev/null
play -n -c1 synth sin %-2 sin %9 sin %5 sin %-7 fade h 0.1 1 0.1 &> /dev/null
play -n -c1 synth 3 sine 300-3300 
play -n -c1 synth 3 sine 300-3300 brownnoise
play -n -c1 synth 0.5 sine 200-500 synth 0.5 sine fmod 700-100
for n in E2 A2 D3 G3 B3 E4 ; do 
	play -n synth 4 pluck $n repeat 2 ; done 
} #}}}
exampleSynths()
{ #{{{
	for type in sine square triangle sawtooth trapezium exp whitenoise tpdfnoise pinknoise brownnoise pluck ; do 
		play -n synth $type %1 fade .1 1 .1 &> /dev/null ; done
} #}}}
generateChord()
{ #{{{
	n1=$((32-$RANDOM % 64))
	n2=$((32-$RANDOM % 64))
	n3=$((32-$RANDOM % 64))
	n4=$((32-$RANDOM % 64))
	n5=$((32-$RANDOM % 64))
	n6=$((32-$RANDOM % 64))

} #}}}
playChord()
{ #{{{
 play -n -c1 synth sin %$n1 sin %$n2 sin %$n3 sin %$n4 sin %$n5 sin %$n6 fade .1 3 .1

} #}}}


#generateChord && playChord
#examplesMansox
#exampleSynths
