#!/bin/bash
# ******************************************
# Program: LAMP Stack Installation Script
# Developer: Pratik Patil
# Date: 10-04-2015
# Last Updated: 11-05-2015
# ******************************************

if [ "`lsb_release -is`" == "LinuxMint" ] || [ "`lsb_release -is`" == "Debian" ]
then
    sudo apt-get -y install mysql-server mysql-client mysql-workbench libmysqld-dev;
    sudo apt-get -y install apache2 php7.0 libapache2-mod-php7.0 php7.0-mcrypt phpmyadmin;
    sudo chmod 777 -R /var/www/;
    sudo printf "<?php\nphpinfo();\n?>" > /var/www/html/info.php;
    sudo service apache2 restart;
else
    echo "Unsupported Operating System";
fi

#Full install Apache2
sudo apt-get -y install apache2;
#ebabled modules
sudo a2enmod rewrite

#Full install mysql
sudo apt-get -y install mysql-server mysql-client mysql-workbench libmysqld-dev;

#Full install PHP7.0
sudo apt-get -y install php7.0-cli php7.0-common libapache2-mod-php7.0 php7.0 php7.0-mysql php7.0-fpm php7.0-curl php7.0-gd php7.0-bz2 php7.0-mcrypt php7.0-curl;

#Addition install
sudo apt-get -y install phpmyadmin;

