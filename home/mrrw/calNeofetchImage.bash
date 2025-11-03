#!/bin/bash

dayNumber=$(date +%u)
dayOfWeek=$(date +%a | head -c 2)
dayOfWeek=Sa
calM()
{
	cal -v --color=never | sed "s/$dayOfWeek / $dayOfWeek/"

}

calM
