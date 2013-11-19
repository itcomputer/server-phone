#!/bin/bash
### Script by Alexis LAUNAY
### MAJ: 19/11/2013
### Blocage des pays ###
ISO="af za al ao ai ag an sa ar am aw au az bs bh bd pw bz bj bm bt by mm bo ba bw br bn bg bf bi kh cm cv cl cn cy co km cg cd kp kr cr ci hr cu dj dm eg ae ec er ee et fj ga gm ge gh gi gr gd gl gp gu gt gn gq gw gy ht hn hk hu cx nf ky ck cc fk fo mh pn sb sj tc vi vg in id ir iq is il jm jp jo kz ke kg ki kw la ls lv lb lr ly li lt mo mk mg my mw mv ml mt mp mu mr mx fm md mn ms mz na nr np ni ne ng nu no nz om ug uz ok pa py nl pe ph pl pr pt qa cf do cz ro ru rw eh kn sh lc sm pm va vc sv ws as st sn yu sc sl sg sk si so sd lk se ch sr sz sy tj tw tz td th tl tg tk to tt tm tv ua uy vu ve vn wf ye zm"
 
### Set PATH ###
IPT=/sbin/iptables
WGET=/usr/bin/wget
EGREP=/bin/egrep
 
### No editing below ###
SPAMLIST="countrydrop"
ZONEROOT="/root/iptables"
DLROOT="http://www.roks.fr/sysprep/iptables"
 
cleanOldRules(){
$IPT -F
$IPT -X
$IPT -t nat -F
$IPT -t nat -X
$IPT -t mangle -F
$IPT -t mangle -X
$IPT -P INPUT ACCEPT
$IPT -P OUTPUT ACCEPT
$IPT -P FORWARD ACCEPT
}
 
# create a dir
[ ! -d $ZONEROOT ] && /bin/mkdir -p $ZONEROOT
 
# clean old rules
cleanOldRules
 
# create a new iptables list
$IPT -N $SPAMLIST
 
for c  in $ISO
do
	# local zone file
	tDB=$ZONEROOT/$c.zone
 
	# get fresh zone file
	$WGET -O $tDB $DLROOT/$c.zone
 
	# country specific log message
	SPAMDROPMSG="$c Country Drop"
 
	# get 
	BADIPS=$(egrep -v "^#|^$" $tDB)
	for ipblock in $BADIPS
	do
	   $IPT -A $SPAMLIST -s $ipblock -j LOG --log-prefix "$SPAMDROPMSG"
	   $IPT -A $SPAMLIST -s $ipblock -j DROP
	done
done
 
# Drop everything 
$IPT -I INPUT -j $SPAMLIST
$IPT -I OUTPUT -j $SPAMLIST
$IPT -I FORWARD -j $SPAMLIST
 
# call your other iptable script
# /path/to/other/iptables.sh
exit 0
