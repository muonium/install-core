#!/usr/bin/env bash

if [ -e /etc/debian_version ];then
    os=$(cat /etc/os-release|grep "VERSION_ID")
    if [ $os="VERSION_ID=\"8\"" ];then #debian jessie
        source ./debian/jessie.sh; #source the right file
        install_jessie; #call the install function
        echo "##############################
        You can now go to http://$me_DOMAINE_NAME:666/
        ##############################";
    fi
fi
