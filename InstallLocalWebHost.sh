#!/bin/bash
#Bash install wab NGINX+PHP7.0-fpm

if [ "`lsb_release -is`" == "LinuxMint" ] || [ "`lsb_release -is`" == "Debian" ] || [ "`lsb_release -is`" == "Ubuntu" ]
then
	#Install mysql
	sudo apt-get -y install mysql-server mysql-client libmysqld-dev;

	#Install PHP7.0
	sudo apt-get -y install php7.0-cli php7.0-common php7.0 php7.0-mysql php7.0-fpm php7.0-curl php7.0-gd php7.0-bz2 php7.0-mcrypt php7.0-curl;

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
