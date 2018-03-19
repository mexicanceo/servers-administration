#!/bin/bash
#cp container.zip "$HOME"
#cd $HOME
#unzip container.zip
#"git clone https://github.com/oblique/create_ap -> if there is internet"
#"cd create_ap"
#"make install"
#echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" >> /etc/apt/sources.list
#echo "deb-src http://http.kali.org/kali kali-rolling main non-free contrib" >> /etc/apt/sources.list
#echo "Starting a script"
#wget -q -O - https://archive.kali.org/archive-key.asc  | apt-key add
apt update
apt install -y hostapd
apt install -y procps
apt install -y haveged
apt install -y iw
apt install -y iwconfig
apt install -y dnsmasq
#apt install -y squid
#cp squid.conf /etc/squid/squid.conf
#cp passwd /etc/squid/
#cp sitios.txt /etc/squid/
#echo "Setting temporary cache"
#squid -z
echo "Restarting the proxy"
#service squid restart
#service ssh start
#apt install -y bind9
#apt install -y isc-dhcp-server
#apt install -y apache2
echo "End of the script"
cd ./create_ap/
make install
chmod 700 create_ap
chmod 700 start.sh
./start.sh
