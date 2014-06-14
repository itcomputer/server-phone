#! /bin/sh
### BEGIN INIT INFO
# Provides: MAJ
# Required-Start: dbus mountall
# Required-Stop:
# Should-Start:
# Should-Stop:
# Default-Start: started dbus and started mountall
# Default-Stop: 2 3 4 5
# Short-Description: Start and stop MAJ
# Description: MAJ pour la version 1.1
### END INIT INFO

echo "SAUVEGARDE DES FICHIERS DE CONFIGURATION"
sleep 2
cd /home/userpbx/
sudo rm /home/.Trash-0/files/*
sudo rm -R /home/.Trash-0/files/*
sudo rm ~/.local/share/Trash/files/*
sudo rm -R ~/.local/share/Trash/files/*
tar -cvzf save_config.tar.gz /etc/ppp/chap-secrets /etc/pptpd.conf /etc/fail2ban/filtrer.d/ /et$
mkdir /var/www/html/sauvegarde
rm -R /var/www/html/sauvegarde/save_config.tar.gz
mv /home/userpbx/save_config.tar.gz /var/www/html/sauvegarde/
rm -R /home/userpbx/save_config.tar.gz

echo "MAJ Systeme"
sleep 2
sudo apt-get update && sudo apt-get -y upgrade && sudo apt-get -y dist-upgrade
# MAJ Raspbx
#raspbx-upgrade

echo "Modification version et message d'accueil SSH"
sleep 2
cd /etc
rm motd
wget https://raw.github.com/itcomputer/server-phone/master/motd
chown -R root:root /etc/motd

echo "Modification des commandes"
sleep 2
cd /home/userpbx
rm -R .bashrc
wget https://raw.github.com/itcomputer/server-phone/master/.bashrc_userpbx
mv .bashrc_userpbx .bashrc
chown -R userpbx:userpbx /home/userpbx/.bashrc
cd /root
rm -R .bashrc
wget https://raw.github.com/itcomputer/server-phone/master/.bashrc_root
mv .bashrc_root .bashrc
chown -R root:root /root/.bashrc
cd /etc/skel
rm -R .bashrc
wget https://raw.github.com/itcomputer/server-phone/master/.bashrc_skel
mv .bashrc_skel .bashrc
chown -R root:root /etc/skel/.bashrc
cd /etc
rm -R reset-network
wget https://raw.github.com/itcomputer/server-phone/master/reset-network
chown -R userpbx:userpbx /etc/reset-network

echo "Modification des fichiers de configuration"
sleep 2
cd /etc/asterisk
rm -R info-port.conf
wget https://raw.github.com/itcomputer/server-phone/master/info-port.conf
chown -R userpbx:userpbx /etc/asterisk/info-port.conf
cd /usr/local/bin
rm -R afficher-ip
wget https://raw.github.com/itcomputer/server-phone/master/afficher-ip
chown -R root:root /usr/local/bin/afficher-ip
chmod +x /usr/local/bin/afficher-ip
cd /var/spool/cron/crontabs
rm -R root
wget https://raw.github.com/itcomputer/server-phone/master/root

echo "Firmware et Langues Cisco"
sleep 2
cd /var/www/html
mkdir cisco
cd cisco
rm -R cisco.tar
wget http://www.itc-informatique.fr/sysprep/cisco.tar
tar -xvf cisco.tar
rm -R cisco.tar

echo "MAJ Sécurité"
sleep 2
#Ban IP
#iptables -I INPUT -s 54.200.235.239 -j DROP
#iptables -I INPUT -s 198.7.59.151 -j DROP
#iptables -I INPUT -s 198.27.68.179 -j DROP
#iptables -I INPUT -s 176.31.123.59 -j DROP
#iptables -I INPUT -s 188.165.252.218 -j DROP
#iptables -I INPUT -s 176.31.65.141 -j DROP
#iptables -I INPUT -s 37.8.45.62 -j DROP
#iptables -I INPUT -s 82.205.11.32 -j DROP
#iptables -I INPUT -s 162.13.4.193 -j DROP
#iptables -I INPUT -s 178.162.205.235 -j DROP
#iptables -I INPUT -s 198.27.68.179 -j DROP
#iptables -I INPUT -s 162.13.4.193 -j DROP
#iptables -I INPUT -s 176.31.65.141 -j DROP
#iptables -I INPUT -s 193.111.136.1 -j DROP
#iptables -I INPUT -s 178.162.205.216 -j DROP
#iptables -I INPUT -s 176.31.0.0 -j DROP
#iptables -I INPUT -s 85.195.73.75 -j DROP
#iptables -I INPUT -s 178.162.0.0 -j DROP
#iptables -I INPUT -s 216.155.138.218 -j DROP
#iptables -I INPUT -s 198.27.0.0 -j DROP
# configuration Fail2Ban
cd /etc/fail2ban/filter.d/
rm -R asterisk.conf
wget https://raw.github.com/itcomputer/server-phone/master/asterisk.conf
cd /etc/fail2ban/
rm -R jail.conf
wget https://raw.github.com/itcomputer/server-phone/master/jail.conf
rm -R jail.local
wget https://raw.github.com/itcomputer/server-phone/master/jail.local
cd /etc/asterisk/
rm -R logger.conf
wget https://raw.github.com/itcomputer/server-phone/master/logger.conf
asterisk -rx "logger reload"
/etc/init.d/fail2ban restart
cd /etc/ssh/
rm -R ssh_config
wget https://raw.github.com/itcomputer/server-phone/master/ssh_config
rm -R sshd_config
wget https://raw.github.com/itcomputer/server-phone/master/sshd_config
service ssh restart
cd /lib/ufw
rm -R user.rules
rm -R user6.rules
wget https://raw.github.com/itcomputer/server-phone/master/user6.rules
wget https://raw.github.com/itcomputer/server-phone/master/user.rules
cd /etc/network/if-pre-up.d/
rm -R iptables
wget https://raw.github.com/itcomputer/server-phone/master/iptables
chmod +x /etc/network/if-pre-up.d/iptables
cd /etc/
rm -R iptables.up.rules
wget https://raw.github.com/itcomputer/server-phone/master/iptables.up.rules

#MAJ Securité désactivé
#cd /root
#rm -R security_iptables
#wget https://raw.github.com/itcomputer/server-phone/master/security_iptables
#chmod +x security_iptables
#./security_iptables

echo "Restauration des fichiers de configuration"
sleep 2
cd /
cp /var/www/html/sauvegarde/save_config.tar.gz save_config.tar.gz
tar zxvf save_config.tar.gz
rm -R save_config.tar.gz

echo "Redémarrage du serveur..."
sleep 2
reboot

exit
