#!/bin/bash
#Checks if apache2 package is installed on the OS
APACHE2=$(dpkg-query -W -f='${Status}' apache2 2>/dev/null | grep -c 'ok installed')
#If the sum is 0 then,
if [ $APACHE2 -eq 0 ]; then
      #Outputs text that shows the package is being installed
      echo "Installing package apache2"
      apt install apache2
      echo "Apache2 Installed"
#If the sum is 1 then,
elif [ $APACHE2 -eq 1 ]; then
      #Outputs text and status showing that the package is installed and running,
      echo "Apache2 is already installed"
      systemctl start apache2
      systemctl status apache2
fi
#End script
