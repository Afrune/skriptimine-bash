#!/bin/bash
#mysql installation script with prerequisites
#Checks status of if mysql is installed
MYSQL=$(dpkq-query -W -f='${Status}' mysql-server 2>/dev/null | grep -c 'ok installed')
#If MYSQL variable equals 0
if [ $MYSQL -eq 0 ]; then
      #Then ok installed wasnt found
      echo "Installing mysql and required prerequisite"
      apt update -y && apt install gnupg wget -y
      wget https://dev.mysql.com/get.mysql-apt-config_0.8.30-1_all.deb
      dpkg -i mysql-apt-config-0.8.30-1_all.deb
      apt update -y
      apt install mysql-server -y
      echo "mysql is installed with prerequisites"
      #Give the possibility of using mysql without user and password
      touch $HOME/.my.cnf  #Add the required config file into the users home folder
      echo "[client]" >> $HOME/.my.cnf
      echo "host = localhost" >> $HOME/.my.cnf
      echo "user = root" >> $HOME/.my.cnf
      echo "password = qwerty" >> $HOME/.my.cnf
# If MYSQL variable equals 1
elif [ $MYSQL -eq 1 ]; then
      #Then ok installed was foudn
      echo "mysql-server is installed"
      #Check
      mysql
#end
fi
