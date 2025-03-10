#!/bin/bash
# ~/bin/clear.bash
# Clear and print useful information into tmux panes.
# ...by mrrw
# set +x  ## debug mode

clear
. ~/.alias

if [[ $TMUX_PANE == %0 ]] ; then
	cd ~ ;
	echo -e "\nWelcome, $USER.\n"
	ls -A --color=auto --group-directories-first . ;
 	ls -A --color=auto --group-directories-first ./* ;
	echo
elif [[ $TMUX_PANE == %1 ]] ; then
	while true; do
		neofetch ;
		sleep 300
	done ;
elif [[ $TMUX_PANE == %2 ]] ; then
	alias git-push
	alias nixos-mrrw
	bash $HOME/bin/pl.bash -t ;
fi
