#!/bin/bash

#Here is a small script where we will send two commands 2 background and
#then wait for them to complete but if they took too long then those will
#be forcefully terminated.

echo "$(date +%H:%M:%S): start"
pids=()
timeout 10 bash -c 'sleep 20; echo "$(date +%H:%M:%S): job 1 terminated successfully"' &
pids+=($!)
timeout 2 bash -c 'sleep 5; echo "$(date +%H:%M:%S): job 2 terminated successfully"' &
pids+=($!)
for pid in ${pids[@]}; do
   wait $pid
   exit_status=$?
   if [[ $exit_status -eq 124 ]]; then
      echo "$(date +%H:%M:%S): $pid terminated by timeout"
   else
      echo "$(date +%H:%M:%S): $pid exited successfully"
   fi
done

#Here, we are using timeout command to monitor the background process
#i.e. sleep. You can replace sleep with actual command or application. As
#you can see, the timeout value is lower then sleep to demonstrate that
#timeout will forcefully terminate the background process.

#We will store the PIDs of the background process into a variable and use
#wait command to monitor those PIDs to complete.

#Output:

#~]# sh /tmp/script.sh
#22:03:27: start
#22:03:37: 7637 terminated by timeout
#22:03:37: 7638 terminated by timeout

#As expected, both the commands are forcefully terminated. timeout will
#terminate any process with exit code 124 so we monitor the exit code to
#confirm the behvaior.
