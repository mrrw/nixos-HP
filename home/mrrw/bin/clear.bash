#!/bin/bash
# ~/bin/clear.bash
# Clear and print useful information into tmux panes.
# ...by mrrw, @2025, no rights reserved
# set +x  ## debug mode

clear

##  Command tmux panes to display a variety of useful information:

main-command()
{
if [[ $TMUX_PANE == %0 ]] ; then
	if [ $(pwd) = $HOME ] ; then
#		cd ~ ;
		echo -e "\nWelcome, $USER.\n"
		ls -A --color=auto --group-directories-first . ;
		echo ""
		ls -A --color=auto --group-directories-first ./* ;
		echo
	else
		n=$(tmux list-panes | grep active | head -c 9 | tail -c 2)
		t=$(($n - 4))
		clear && pwd
		if [ $(tree -L3 | wc -l) -le $t ] ; then
			tree -L3 --dirsfirst
		elif [ $(tree -L2 | wc -l) -le $t ] ; then
			tree -L2 --dirsfirst
		elif [ $(tree -L1 | wc -l) -le $t ] ; then
			tree -L1 --dirsfirst
		else
			echo '.'
			ls --color=auto --group-directories-first
			tree | tail -2
		fi
	fi
elif [[ $TMUX_PANE == %1 ]] ; then
	while true; do
		neofetch ;
		battery-status ;
		sleep 60
	done ;
elif [[ $TMUX_PANE == %2 ]] ; then
	pane2message
fi
}

battery-status()
{

d="/sys/class/power_supply/BAT0"
f1=$d/charge_full
f2=$d/charge_now
A=$(cat $f1)
B=$(cat $f2)
# declare -i status=($B/$A*100)
# echo "$status"
#expr $(cat $f1) / $(cat $f2)

#echo $(($(cat $f1) / $(cat $f2)))
# Teach bash e.g. integer division with floating point results:

div ()  # Arguments: dividend and divisor
{
        if [ $2 -eq 0 ]; then echo division by 0; return 1; fi
        local p=12                            # precision
        local c=${c:-0}                       # precision counter
        local d=.                             # decimal separator
        local r=$(($1/$2)); echo -n $r        # result of division
        local m=$(($r*$2))
        [ $c -eq 0 ] && [ $m -ne $1 ] && echo -n $d
        [ $1 -eq $m ] || [ $c -eq $p ] && echo && return
        local e=$(($1-$m))
        c=$(($c+1))
        div $(($e*10)) $2
}
if [[ $A == $B ]] ; then
	result=100
else
	result=$(div $B $A | head -c 4 | tail -c 2)
fi
    echo -e "\t\tBattery: $result%"
	}
pane2message()
{
	bash $HOME/lib/clear/pane2message.bash
	echo "----------------------------------------------------------------------"
	bash $HOME/bin/pl.bash -t
}

	main-command
