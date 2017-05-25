install_jessie(){
    source ../vars.sh;
    apt-get install git apache2 php5 php5-mysql mariadb-server -y;
    mkdir -p /srv/muonium;mkdir -p /srv/muonium/nova;
    git clone https://github.com/muonium/core /srv/muonium/core;

    if [ -z "$apache_USER" ];then
        apache_USER=www-data;
    fi
    if [ -z "$apache_GROUP" ];then
        apache_GROUP=www-data;
    fi

    mkdir -p /etc/ssl/mui;cd /etc/ssl/mui;
    if [ -z "$bits_SSL" ];then
        bits_SSL=4096;
    fi
    openssl req -x509 -newkey rsa:$bits_SSL -keyout key.pem -out cert.pem -days $days_SSL -subj "/C=$me_COUNTRY" -nodes -sha256;
    cd -;

    chown -R $apache_USER:$apache_GROUP /srv/muonium;

    echo "
    listen 666
    <VirtualHost *:666>
        DocumentRoot \"/srv/muonium/\"

        Protocol https

        <Directory />
            Require all granted
            AllowOverride All
            Options None
        </Directory>
        SSLEngine On
        SSLCertificateFile /etc/ssl/mui/cert.pem
        SSLCertificateKeyFile /etc/mui/key.pem

    </VirtualHost>
    "> /etc/apache2/sites-available/muonium.conf;
    cd /etc/apache2/sites-available/;a2ensite muonium.conf; #enable the vhost
    a2enmod rewrite;a2enmod ssl;
    systemctl restart apache2.service;
    cd -; #Come Back Mister ~
    chmod +x ./mysql_config.sh;
    ./mysql_config.sh;

}
