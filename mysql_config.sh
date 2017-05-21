#!/bin/bash
#AUTHOR: Dylan Clement
echo "Muonium Database installation"

while [ -z "$user" ]; do
	echo "Please enter your database username and press [ENTER] :"
	read user
done

echo "Please enter your database password and press [ENTER] :"
read password
echo "Please enter the name of the database you want to use for Muonium (default : cloud) and press [ENTER] :"
read db

if [ -z "$db" ]; then
    db='cloud'
fi

Q1="CREATE DATABASE IF NOT EXISTS $db;"
Q2="GRANT ALL ON *.* TO '$user'@'localhost' IDENTIFIED BY '$password';"
Q3="FLUSH PRIVILEGES;"
SQL="${Q1}${Q2}${Q3}"

mysql --password=$password --user=$user -e "$SQL"
mysql --password=$password --user=$user $db < cloud.sql
