#!/bin/bash
#AUTHOR: Dylan Clement
echo "Muonium Database installation"

source vars.sh;
echo "Please enter the name of the database you want to use for Muonium (default : cloud) and press [ENTER] :"
read db

if [ -z "$db" ]; then
    db='cloud'
fi

Q1="CREATE DATABASE IF NOT EXISTS $db;"
Q2="GRANT ALL ON *.* TO '$mysql_USER'@'localhost' IDENTIFIED BY '$mysql_PASSWD';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"

wget https://raw.githubusercontent.com/muonium/core/master/cloud.sql;

mysql --password=$mysql_PASSWD --user=$mysql_USER -e "$SQL"
mysql --password=$mysql_PASSWD --user=$mysql_USER $db < cloud.sql;

rm cloud.sql;
