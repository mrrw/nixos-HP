#! /bin/bash
# alias now = '~/.now.sh


Exec_NOW()
{ #{{{
# Display calendar and weather.  Refresh periodically.
clear
echo
echo "Today is $(date +%A), $(date +%B) $(date +%d)."
echo
echo
cal -3vm 
echo
curl wttr.in 
echo
echo "Weather snapshot taken $(date)"
# feh --no-xinerama -z --bg-fill ~/Pictures/* 
sleep 600 && ~/bin/now.sh

} #}}}
