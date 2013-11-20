#!/bin/bash
#Script de MAJ pour l'IPBX d'ITC
#Alexis LAUNAY configuration ITC.
#Site internet: www.itcomputer.fr
## MAJ Version 1.0.3 le 18/11/2013

#Installation d'un serveur VNC
#MAJ + Dépendances

echo "MAJ de raspbx"
sleep 2
#mv /root/pptpd-options /etc/ppp/pptpd-options
#mv /root/sysctl.conf /etc/sysctl.conf
#sysctl -p

echo "Modification version et message d'accueil SSH"
sleep 2
cd /etc
rm motd
wget https://raw.github.com/itcomputer/server-phone/master/motd
chown -R root:root /etc/motd

echo "Modification des commandes"
sleep 2
cd /home/userpbx
rm .bashrc
wget https://raw.github.com/itcomputer/server-phone/master/.bashrc_userpbx
mv .bashrc_userpbx .bashrc
chown -R userpbx:userpbx /home/userpbx/.bashrc
cd /root
rm .bashrc
wget https://raw.github.com/itcomputer/server-phone/master/.bashrc_root
mv .bashrc_root .bashrc
chown -R root:root /root/.bashrc
cd /etc/skel
rm .bashrc
wget https://raw.github.com/itcomputer/server-phone/master/.bashrc_skel
mv .bashrc_skel .bashrc
chown -R root:root /etc/skel/.bashrc
cd /etc
rm reset-network
wget https://raw.github.com/itcomputer/server-phone/master/reset-network
chown -R userpbx:userpbx /etc/reset-network

echo "Modification des fichiers de configuration"
sleep 2
cd /etc/asterisk
rm info-port.conf
wget https://raw.github.com/itcomputer/server-phone/master/info-port.conf
chown -R userpbx:userpbx /etc/asterisk/info-port.conf

echo "Installation des dépendances"
sleep 2
#apt-get -y install build-essential
#apt-get -y install libxml2-dev
#apt-get -y install libncurses5-dev
#apt-get -y install linux-headers-`uname -r`
#apt-get -y install libsqlite3-dev
#apt-get -y install libssl-dev perl
#apt-get -y install libwww-perl
#apt-get -y install sox mpg123
#apt-get -y install zip
#apt-get -y install pptpd
#apt-get -y install openvpn
#apt-get -y install tightvncserver
#apt-get -y install ufw
#apt-get -y install gufw
#apt-get -y install fbi

# verification des dépendances.
#apt-get -y install build-essential libxml2-dev libncurses5-dev linux-headers-`uname -r` libsqlite3-dev libssl-dev perl libwww-perl sox mpg123 zip pptpd openvpn tightvncserver ufw gufw fbi


echo "Installation de No-IP"
sleep 2


echo "Copie des fichiers de configuration Asterisk"
sleep 2
#cd /etc/asterisk/
#rm extensions.conf
#mv /root/sip.conf /var/www/html/admin/modules/core/etc
#mv /root/extensions.conf /var/www/html/admin/modules/core/etc
#mv /root/voicemail.conf /var/www/html/admin/modules/core/etc
#mv /root/users.conf /var/www/html/admin/modules/core/etc
#mv /root/musiconhold.conf /var/www/html/admin/modules/core/etc
#chown -R asterisk:asterisk /var/www/html/admin/modules/core/etc
#mv /root/voicemail.conf /etc/asterisk
#mv /root/users.conf /etc/asterisk
#mv /root/musiconhold.conf /etc/asterisk
#chown -R asterisk:asterisk /etc/asterisk
#mv /root/fr /var/lib/asterisk/sounds/
#mv /root/itc.mp3 /var/lib/asterisk/sounds
#mv /root/IVR-000.ulaw /var/lib/asterisk/sounds
#mv /root/IVR-001.ulaw /var/lib/asterisk/sounds
#mv /root/IVR-002.ulaw /var/lib/asterisk/sounds
#mv /root/IVR-003.ulaw /var/lib/asterisk/sounds
#mv /root/IVR-004.ulaw /var/lib/asterisk/sounds
#mv /root/IVR-005.ulaw /var/lib/asterisk/sounds
#mv /root/IVR-006.ulaw /var/lib/asterisk/sounds
#chown -R asterisk:asterisk /var/lib/asterisk/sounds

echo "MAJ"
sleep 2
cd /var/www/html
rm -R itcpbx_site.png
wget http://www.roks.fr/sysprep/itcpbx_site.png
rm -R index.php
wget https://raw.github.com/itcomputer/server-phone/master/index.php
cd /var/lib/asterisk/sounds
mv itc.mp3 itc2.mp3
wget http://www.roks.fr/sysprep/itc.mp3

echo "MAJ"
sleep 2
aptitude -y install libapache2-mod-geoip
a2enmod geoip
cd /var/www/


echo "Firmware et Langues Cisco"
sleep 2
cd /var/www/html
rm -R cisco.tar
wget http://www.roks.fr/sysprep/cisco.tar
tar -xvzf cisco.tar
rm -R cisco.tar

echo "MAJ Sécurité"
sleep 2
#Ban IP
iptables -I INPUT -s 54.200.235.239 -j DROP
iptables -I INPUT -s 198.7.59.151 -j DROP
iptables -I INPUT -s 198.27.68.179 -j DROP
iptables -I INPUT -s 176.31.123.59 -j DROP
iptables -I INPUT -s 188.165.252.218 -j DROP
# configuration Fail2Ban
cd /etc/fail2ban/filter.d/
rm -R asterisk.conf
wget https://raw.github.com/itcomputer/server-phone/master/asterisk.conf
cd /etc/fail2ban/
rm -R jail.conf
wget https://raw.github.com/itcomputer/server-phone/master/jail.conf
cd /etc/asterisk/
rm -R logger.conf
wget https://raw.github.com/itcomputer/server-phone/master/logger.conf
asterisk -rx "logger reload"
/etc/init.d/fail2ban restart
cd /etc/ssh
rm -R sshd_config
wget https://raw.github.com/itcomputer/server-phone/master/sshd_config
service ssh restar
cd /lib/ufw
rm -R user.rules
rm -R user6.rules
wget https://raw.github.com/itcomputer/server-phone/master/user6.rules
wget https://raw.github.com/itcomputer/server-phone/master/user.rules
cd /root
rm -R iptables_pays
wget https://raw.github.com/itcomputer/server-phone/master/iptables_pays
chmod +x iptables_pays
./iptables_pays


#echo "Redémarrage du serveur..."
#sleep 2
#reboot

exit
