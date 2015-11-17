#!/bin/bash

HOST="Unknown";

if [ "$1" != "" ]; then
    HOST="$1";
else
    echo "Enter hosthame: ";
    read HOST;
fi 

echo "Delete virtual domain $HOST";

DIR="/home/shinekami/work/web/server/$HOST"

if [ "$DIR" ]; then
	rm -r "$DIR" > /dev/null
	a2dissite $HOST".conf" > /dev/null
	sed -i "/127.0.0.1\t$HOST www.$HOST/d" /etc/hosts
	rm "/etc/apache2/sites-available/$HOST.conf" > /dev/null
	apache2ctl restart > /dev/null
else
    echo "Host not found";
fi 
