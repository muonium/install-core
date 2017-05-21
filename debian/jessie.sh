install_jessie(){
    source ../vars;
    apt-get install git apache2 php5 php5-mysql mariadb-server -y;
    mkdir -p /srv/muonium;mkdir -p /srv/muonium/nova;
    git clone https://github.com/muonium/core /srv/muonium/;
    chown -R $apache_USER:$apache_GROUP /srv/muonium;
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

    echo $conf_apache > /etc/apache2/sites-available/muonium.conf; #put the conf in the vhost
    cd /etc/apache2/sites-available/;a2enmod muonium.conf; #enable the vhost
    a2enmod rewrite;
    systemctl restart apache2.service;
    cd -; #Come Back Mister ~

    chmod +x ./mysql_config.sh;
    ./mysql_config.sh;

}
