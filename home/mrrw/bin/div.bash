# Teach bash e.g. integer division with floating point results:

#!/bin/bash

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

    result=$(div 1080 633)                  # write to variable
    echo $result

    result=$(div 7 34)
    echo $result

    result=$(div 8 32)
    echo $result

    result=$(div 246891510 2)
    echo $result

    result=$(div 5000000 177)
    echo $result
