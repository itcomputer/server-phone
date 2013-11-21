#!/bin/bash
#Script de MAJ pour l'IPBX d'ITC
#Alexis LAUNAY configuration ITC.
#Site internet: www.itcomputer.fr
## MAJ Version 1.0.4 le 20/11/2013

#Installation d'un serveur VNC
#MAJ + Dépendances

echo "MAJ Sécurité"
sleep 2
# configuration Fail2Ban
cd /etc/ssh/
rm -R ssh_config
wget https://raw.github.com/itcomputer/server-phone/master/ssh_config
rm -R sshd_config
wget https://raw.github.com/itcomputer/server-phone/master/sshd_config
service ssh restart



#echo "Redémarrage du serveur..."
#sleep 2
#reboot

exit
