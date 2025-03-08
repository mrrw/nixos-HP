#!/bin/bash
# ~/bin/clear.bash
# Clear and print useful information into tmux panes.
# ...by mrrw

clear
. ~/.alias
echo ''

if [[ $TMUX_PANE == %0 ]] ; then
	cd ~ ;
	echo -e "Welcome, $USER.\n"
	ls -A --color=auto --group-directories-first . ;
 	ls -A --color=auto --group-directories-first ./* ;
elif [[ $TMUX_PANE == %1 ]] ; then
	neofetch ;
elif [[ $TMUX_PANE == %2 ]] ; then
	alias git-push
	alias nixos-mrrw
	bash $HOME/bin/pl.bash -t ;
fi
