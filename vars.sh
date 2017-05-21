#apache
apache_USER=www-data
apache_GROUP=www-data

#mysql
mysql_USER=root
mysql_PASSWD=root


#CONFS
conf_apache='
<VirtualHost *:80>
    DocumentRoot "/srv/muonium/"

    <Directory />
        Require all granted
        AllowOverride All
        Options None
    </Directory>
</VirtualHost>
'
