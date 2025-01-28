#!/bin/bash

#Checks for and installs prerequisites
if ! dpkg -l | grep -qw apache2; then
    echo "Apache2 not found, installing"
    apt update -y
    apt install apache2 -y
else
    echo "Apache2 is already installed"
fi

if ! dpkg -l | grep -qw mysql-server; then
    echo "MySQL not found, installing"
    apt install mysql-server -y
else
    echo "MySQL is already installed."
fi

if ! dpkg -l | grep -qw php; then
    echo "PHP not found, installing"
    apt install php libapache2-mod-php php-mysql -y
else
    echo "PHP is already installed"
fi

if ! dpkg -l | grep -qw phpmyadmin; then
    echo "PHPMyAdmin not found, installing"
    apt install phpmyadmin -y
else
    echo "PHPMyAdmin is already installed."
fi

#Start and enable Apache2 and MySQL
systemctl start apache2
systemctl enable apache2
systemctl start mysql
systemctl enable mysql
#Setup MySQL database and user for wordpress
echo "Setting up MySQL database and user for WordPress"
mysql -e "CREATE DATAbase iF NOT EXISTS wordpress;"
mysql -e "CREATE USER IF NOT EXISTS 'wpuser'@'localhost' IDENTIFIED BY 'qwerty';"
mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'localhost';"
mysql -e "FLUSH PRIVILEGES;"
#Download and install WordPress
echo "Downloading and installing WordPress"
cd /tmp
wget https://wordpress.org/latest.tar.gz
tar -xvzf latest.tar.gz
mv wordpress /var/www/html/wordpress
#Set permissions for WordPress files
chown -R www-data:www-data /var/www/html/wordpress
#Configure wp-config.php
echo "Configuring wp-config.php with MySQL"
cd /var/www/html/wordpress
cp wp-config-sample.php wp-config.php
#Insert database info into wp-config.php
sed -i "s/database_name_here/wordpress/" wp-config.php
sed -i "s/username_here/wpuser/" wp-config.php
sed -i "s/password_here/qwerty/" wp-config.php
#Restart Apache2 to apply changes
echo "Restarting Apache2
systemctl restart apache2
echo "WordPress installation complete!, you can acces it at http://your_server_ip/wordpress"
