#!/bin/bash
#phpmyadmin installation script
#
#Checks if phpmyadmin is installed, if not then installs it
PMA=$(dpkq-query -W -f='${Status}' phpmyadmin 2>/dev/null | grep -c 'ok installed')
#If the PMA variable is equal to 0
if [ $PMA -eq 0 ]; then
     #If ok installed wasnt found
     echo "Installing phpmyadmin and required assets"
     apt update
     apt install mariadb-server mariadb-client
     apt install phpmyadmin
     echo "phpmyadmin is installed"
#If the PMA variable is equal to 1
elif [ $PMA -eq 1 ]; then
     #If ok installed was found
     echo "phpmyadmin is already installed"
     #Check
#end
fi
