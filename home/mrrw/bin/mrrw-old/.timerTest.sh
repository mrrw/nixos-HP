#!/bin/bash
#
# echo's "OK" for awhile.

runtime="5 minute"
endtime=$(date -ud "$runtime" +%s)
while [[ $(date -u +%s) -le $endtime ]]
do
	echo OK
	sleep 10
done


