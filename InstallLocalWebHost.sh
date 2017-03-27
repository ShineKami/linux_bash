#!/bin/bash
#Bash install wab NGINX+PHP7.0-fpm

if [ "`lsb_release -is`" == "LinuxMint" ] || [ "`lsb_release -is`" == "Debian" ] || [ "`lsb_release -is`" == "Ubuntu" ]
then
	sudo apt-get update;

	#Install ngix
	sudo apt-get -y install nginx;
	sudo systemctl enable nginx;

	#Install mysql
	sudo apt-get -y install mysql-server;
	sudo mysql_secure_installation;
	sudo systemctl mysql-server mysql-server;

	#Install PHP7.0
	sudo apt-get -y install php7.0-fpm php7.0-cli php7.0-common php7.0-mysql;
	sudo sed 's/;cgi.fix_pathinfo=1/cgi.fix_pathinfo=0/g' /etc/php/7.0/fpm/php.ini > /etc/php/7.0/fpm/php.out;
	sudo rm /etc/php/7.0/fpm/php.ini;
	sudo mv /etc/php/7.0/fpm/php.out /etc/php/7.0/fpm/php.ini;
	sudo sed 's/listen = /var/run/php7.0-fpm.sock/listen = 127.0.0.1:9000/g' /etc/php/7.0/fpm/pool.d/www.conf > /etc/php/7.0/fpm/pool.d/www.out;
	sudo rm /etc/php/7.0/fpm/pool.d/www.conf;
	sudo mv /etc/php/7.0/fpm/pool.d/www.out /etc/php/7.0/fpm/pool.d/www.conf;
	sudo system restart php7.0-fpm;
	sudo systemctl enable php-7.0-fpm;

	#Addition install
	sudo apt-get -y install phpmyadmin;
	#Create symbollink for phpmyadmin in default hostroot
	sudo ln -s /usr/share/phpmyadmin/ /var/www/html

	sudo chmod 755 -R /var/www/;
	sudo printf "<?php\nphpinfo();\n?>" > /var/www/html/info.php;
	sudo systemctl nginx start;
else
    echo "Unsupported Operating System";
fi
