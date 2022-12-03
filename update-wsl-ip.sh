#!/bin/bash

if [ -z $1 ] #Check that we provided and cmd line arg
then
    echo "Need to specify either 'local' or 'remote'"
elif [ $1 == 'local' ] || [ $1 == 'remote' ] #Check it was a sensible cmd arg
then
    #Remove old IP from ssh/known_hosts
    OLDIP=$(grep -m 1 -oE 172.* ~/.ssh/config)
    # echo $OLDIP
    ssh-keygen -R $OLDIP

    #Fetch wsl instance's new IP 
    # IP=$(ssh desktop-$1 "bash.exe -c 'hostname --all-ip-addresses'")
    IP=$(ssh desktop-$1 "hostname --all-ip-addresses")
    # echo $IP

    #Replace local ssh-config file with updated IP (trailing g == 'global' means replace all occurences)
    sed -i.bak "s/ HostName 172.[0-9]*.[0-9]*.[0-9]*/ HostName ${IP}/g" .ssh/config
else
    echo "Need to specify either 'local' or 'remote'"
fi