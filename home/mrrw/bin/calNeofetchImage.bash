#!/bin/bash

dayNumber=$(date +%d)
dayOfWeek=$(date +%a | head -c 2)
dateISO=$(date +%F)

calDefault()
{
	cal -v --color=never | sed "s/$dayOfWeek / $dayOfWeek/"

}
calM_()
{
	echo -en "\`"
	date +%g__%b
	echo "Su "| sed "s/$dayOfWeek / $dayOfWeek/"
	echo "Mo "| sed "s/$dayOfWeek / $dayOfWeek/"
	echo "Tu "| sed "s/$dayOfWeek / $dayOfWeek/"
	echo "We "| sed "s/$dayOfWeek / $dayOfWeek/"
	echo "Th "| sed "s/$dayOfWeek / $dayOfWeek/"
	echo "Fr "| sed "s/$dayOfWeek / $dayOfWeek/"
	echo "Sa "| sed "s/$dayOfWeek / $dayOfWeek/"

}
calM()
{
# variables:
	DAYS=('Su' 'Mo' 'Tu' 'We' 'Th' 'Fr' 'Sa')
	D=$dayOfWeek
	N=$dayNumber
# commands:
	echo -en "\`"
	date +%g__%b
	for s in ${DAYS[@]} ; do
		echo -n "$s  " | sed "s/$D / $D/" && monthBuild
		echo "$N"
	done
}
monthBuild()
{
	today=$(date +%d)
	frtnt=$(date -d '+14 day' +%d)
	if [ $today -gt $frtnt ] ; then
		echo -n "wow!"
	fi
}



#calDefault
calM
