#!/bin/bash

HOST="Unknown";

if [ "$1" != "" ]; then
    HOST="$1";
else
    echo "Enter hosthame: ";
    read HOST;
fi 

echo "Creating virtual domain $HOST.ps with allias www.$HOST";

echo "#VirtualHost Config File for host $HOST
<VirtualHost *:80>
	ServerName $HOST
	ServerAlias www.$HOST
	ServerAdmin admin@$HOST
	DocumentRoot /home/shinekami/work/web/server/$HOST/

	<Directory /home/shinekami/work/web/server/$HOST/>
		Options Indexes FollowSymLinks
		AllowOverride None
		Require all granted
	</Directory>

	ErrorLog ${APACHE_LOG_DIR}/error.log
	CustomLog ${APACHE_LOG_DIR}/access.log combined
</VirtualHost>
" > "/etc/apache2/sites-available/$HOST.conf"

DIR="/home/shinekami/work/web/server/$HOST/"

mkdir -p $DIR > /dev/null
chmod -R 777 "$DIR/../";

echo "127.0.0.1	$HOST www.$HOST" >> /etc/hosts

a2ensite $HOST".conf" > /dev/null
apache2ctl restart > /dev/null
