#!/bin/bash
#php  installation script

PHP=$(dpkg-query -W -f='${Status}' php7.0 2>/dev/null | grep -c 'ok installed')
#If PHP variable equals 0
if [ $PHP -eq 0 ]; then
     #then ok installed is not found
     #echo related respone and then install it
     echo "Paigaldame php ja vajalikud lisad"
     apt install php7.0 libapache2-mod-php7.0 php7.0-mysql
     echo "php on paigaldatud"
#If PHP variable equals 1
elif [ $PHP -eq 1 ]; then
     #then ok installed is found
     #package is already installed
     echo "php on juba paigaldatud"
     #check
     which pvp
#end
fi
