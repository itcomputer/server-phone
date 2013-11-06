#!/bin/bash
#Script de MAJ auto pour l'IPBX d'ITC
#Alexis LAUNAY configuration ITC.
#Site internet: www.itcomputer.fr
## MAJ Version 1.1 le 10/11/2013

echo "Modification version et message d'accueil SSH"
sleep 2
cd /etc
rm motd
wget https://github.com/itcomputer/server-phone/blob/master/motd
chown -R root:root /etc/motd

exit
