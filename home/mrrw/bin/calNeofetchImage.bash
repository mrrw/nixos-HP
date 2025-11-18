#!/bin/bash

dateISO=$(date +%F)  ## Todays date in full
N=$(date +%d) D=  ## Day Number
D=$(date +%a | head -c 2) ## Day Of Week
DAYS=('Su' 'Mo' 'Tu' 'We' 'Th' 'Fr' 'Sa')

calDefault() { cal -v --color=never | sed "s/$dayOfWeek / $dayOfWeek/"
}
calPrint() { headerBuild && calBuild
}
calBuild() {
	for s in ${DAYS[@]} ; do
		echo -n "$s  " | sed "s/$D / $D/" && monthBuild
		echo "$N"
	done
}
headerBuild() { fortnight=$(date -d '+14 day' +%d)
	e1=$(echo -en "\`")
	d1=$(date +%g__%b)
	d2=$(date --date='next month' +%b)
	if [[ "$N" -lt "$fortnight" ]] ; then
		header=$e1$d1
	else
		header=$e1$d1$d2
	fi
	echo $header
}
monthBuild() {
echo -n $N
}

#calDefault
calPrint
