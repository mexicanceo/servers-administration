#/bin/bash
#developed by jesus Antonio Rosas Percastre
#Version 2 now allow to connect to an open network,WEB AND WPA2
#Script developed in order to allow connection dynamically
#develped for the class of server's administration
#we recommend running this command if you are the administrator
opc=""
while [ "$opc" != "12" ]; do
echo "1 See all the interfaces"
echo "2 See the pci interfaces"
echo "3 Identify driver and firware for an interface"
echo "4 Remove a module for an interface"
echo "5 Reload a module for an interface"
echo "6 Connect statically to a network (WIRED/WIRELESSLY)"
echo "7 Connect Dynamically to a network WEB (WIRELESSLY)"
echo "8 Connect Dynamically to a network (WIRED)"
echo "9 Define a route to a network "
echo "10 Connect to an Open network (OPEN) wirelessly"
echo "11 Connect to a WPA2 network wirelessly"
echo "12 Exit"
read opc
	case $opc in
		"1")
echo "current interfaces in the system"
echo -e  "\a"
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d' | sed 's/://'
echo "__________________-"
		;;
		"2")
echo "current Modules for network interfaces"
lspci | grep Ethernet
lspci | grep Network
echo "Current modules Found in the system"
echo "___________________"
		;;
		"3")
echo "Identifying General information"
echo "type the INTERFACE to know the information"
echo "List of interfaces found in the system"
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d' | sed 's/://'
read iface
echo "DRIVER/MODULE FOR CARD $iface"
ethtool -i $iface | grep driver
echo "FIRWARE VERSION FOR $iface"
ethtool -i $iface | grep firmware-version
echo "__________________________-"
		;;
		"4")
echo "removing a module of an interface"
echo "type the name of the interface to remove the module"
echo "List fo interfaces : "
echo "___________________"
ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d' | sed 's/://'
read ifc
echo "___________________"
driver=$(ethtool -i $ifc | grep driver | sed 's/driver//' | sed 's/://')
#lsmod | grep "$driver"
rmmod $driver
echo "module deleted sucessfully"
		;;
		"5")
	echo "Type the name of the module to load"
	echo "Type it manually EXAMPLE athck"
	read ifc
	modprobe $driver
	if [ $? -eq 0 ] ; then
	echo "List fo interfaces :"
	echo "_______________"
	ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d' | sed 's/://'
	echo "module loaded sucessfully sucessfully"
	echo "_______________"
	else
	echo "ERROR the module does not exist of it's busy"
	echo "_______________"
	fi
		;;
		"6")
	echo "connecting through STATICALLY /WIRED/WIRELESS"
	echo "connecting staticlly through the terminal"
	echo "current interfaces in the system"
	ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d' | sed 's/://'
	echo "__________________-"
	# systemctl stop network-manager
	echo "Type the interface"
	read iface
	echo "Type the ip Address to set EXAMPLE 192.168.1.2"
	read net
	echo "type the network mask EXAMPLE 255.255.255.0"
	read netmask
	echo "type the broadcast address EXAMPLE 192.168.1.255"
	read brod
	ifconfig  $iface $net netmask $netmask broadcast $brod up
	echo "Address set sucessfully"
	echo "_________________________"
		;;
		"7")
	rfkill  unblock all
	echo "connecting dynamically wirelessly "
	echo "type the interface to connect wirelessly"
	echo "current interfaces in the system"
	echo "IT ONLY WORKS WITH WEP networks"
        ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d' | sed 's/://'
	echo "______________"
	read iface
	echo "Available Networks Around"
	iwlist $iface scan | grep ESSID | sed 's/ESSID//'
	echo "type the network to connect"
	read net
	echo "type the password for $net"
	read -s password
	iwconfig $iface essid $net key "s:$password"
	echo "Trying to connect asking an ip address ..."
	dhclient -v $iface
	echo ip add
	echo "_______End of the query________"
		;;
		"8")
	echo "WIRED DYNAMIC ADDRESS"
	echo "type the interface to connect dynamically"
        echo "current interfaces in the system"
        ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d' | sed 's/://'
	echo "_______________"
	read iface
        dhclient -v $iface
        echo "End of the query"
	echo "____________"
		;;
		"9")
	echo "Define a route to a network"
	echo "Network for the route EXAMPLE 192.168.1.0"
        read net
        echo "type the prefix EXAMPLE /24"
        read prefix
        echo "type the ip of the gateway EXAMPLE 192.168.1.1"
        read gwy
        ip route add "$net$prefix" via  $gwy
        echo "Route defined sucessfull"
		;;
		"10")
	echo "connecting to a wireless OPEN network"
	rfkill  unblock all
        echo "connecting dynamically wirelessly "
        echo "type the interface to connect wirelessly"
        echo "current interfaces in the system"
        echo "IT ONLY WORKS WITH WEP networks"
        ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d' | sed 's/://'
        echo "______________"
        read iface
        echo "Available Networks Around"
        iwlist $iface scan | grep ESSID | sed 's/ESSID//'
        echo "type the network to connect"
        read net
        iwconfig $iface essid $net
        echo "Trying to connect asking an ip address ..."
        dhclient -v $iface
        echo ip add
        echo "_______End of the query________"
		;;
		"11")
	echo "Connecting to a WPA2"
	rfkill  unblock all
        echo "connecting dynamically wirelessly "
        echo "type the interface to connect wirelessly"
        echo "current interfaces in the system"
        echo "IT ONLY WORKS WITH WPA2 networks"
        ifconfig -a | sed 's/[ \t].*//;/^\(lo\|\)$/d' | sed 's/://'
        echo "______________"
        read iface
        echo "Available Networks Around"
        iwlist $iface scan | grep ESSID | sed 's/ESSID//'
        echo "type the network to connect"
        read net
        echo "type the password for $net"
        read -s password
	wpa_passphrase $network $password > /etc/wpa_supplicant.conf
	wpa_supplicant -B -D nl80211 -i $iface -c /etc/wpa_supplicant.conf
        echo "Trying to connect asking an ip address ..."
        dhclient -v $iface
        echo ip add
        echo "_______End of the query________"
		;;
		"12")
echo "Thanks for using my script made at FEI"
		;;
		*)
	echo -e "\awell this is awkard but this not a valid option"
		;;
	esac
done

