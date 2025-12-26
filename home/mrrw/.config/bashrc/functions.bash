cd-mrrw() {
	set -x
	n=$(tmux list-panes | grep active | head -c 9 | tail -c 2)
	t=$(($n - 4))
	cd $1 
		if [ $(pwd) = $HOME ] ; then
			bash $HOME/bin/clear.bash
		else
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
	i=$(find .init 2>/dev/null) && [ ! -z $i ] && . $i
	set +x
}

cda-mrrw() {  # cd-mrrw showing hidden files
	n=$(tmux list-panes | grep active | head -c 9 | tail -c 2)
	t=$(($n - 4))
	cd $1 
		if [ $(pwd) = $HOME ] ; then
			bash $HOME/bin/clear.bash
		else
			clear && pwd
			if [ $(tree -a -L3 | wc -l) -le $t ] ; then
				tree -a -L3 --dirsfirst
			elif [ $(tree -a -L2 | wc -l) -le $t ] ; then
				tree -a -L2 --dirsfirst
			elif [ $(tree -a -L1 | wc -l) -le $t ] ; then
				tree -a -L1 --dirsfirst
			else
				echo '.'
				ls --color=auto --group-directories-first -a
				tree -a | tail -2
			fi
		fi
	i=$(find .init 2>/dev/null) && [ ! -z $i ] && . $i
}
cd-mrrw() {
\cd $1
clear
}
