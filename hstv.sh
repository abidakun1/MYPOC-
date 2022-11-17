#!/bin/bash

G='\033[0;32m'
R='\033[0;31m'

echo -e "\nCHECK: HTTP STRICT TRANSPORT VULNERABILITY"

if [ -z $1 ]

then echo -e "\nUSAGE: hstv.sh  https://site.com \n"
exit 1

fi

curl -s -D- $1 | grep -i strict

if [ $? == 0 ]; then

   echo -e "\n ${R}NOT VULNERABLE -: Http Strict TS present"

else

echo -e "\n ${G}VULNERABLE -: Http Strict TS absent"

fi

exit 0
