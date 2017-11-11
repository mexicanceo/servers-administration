#!/bin/bash
#Script developed by Jesus Antonio Rosas Percastre
#this script will work any time the UV page updates
#Using push.js as a main solution
#"if you want to customize more this script check this page"
#https://www.uv.mx/prensa/seccion/ultimas-noticias/
ORIGINAL=`cat /etc/push/notifications`
if [ -z "$ORIGINAL" ] ; then
	echo "First execution of the program"
	#"This is the initial value for the first execution"
	wget www.uv.mx/fei
	cat fei | grep "<h2>" | sed 's/<h2>//g' | md5sum > /etc/push/notifications
	rm fei
	echo "Current Hash!!"
	cat /etc/push/notifications
	echo "opening browser at $(date)" >> modification.log
	#"ubuntu solution"
	#gnome-open /etc/push/push.html
	gnome-www-browser /etc/push/push.html
else
	ORIGINAL=`cat /etc/push/notifications`
	wget www.uv.mx/fei
	NEW=$(cat fei | grep "<h2>" | sed 's/<h2>//g' | md5sum)
	echo $NEW > /etc/push/notifications
	echo "hash original: $ORIGINAL"
	echo "hash nuevo : $NEW"
	if [ "$ORIGINAL" != "$NEW" ] ; then
	echo "The Page has been Updated Creating notification"
        echo "sending notifications ... at $(date)"
	echo "$NEW"  > /etc/push/notifications
	echo "Opening the Browser" >> modification.log
	#"solution for ubuntu"
        #gnome-open /etc/push/push.html
	gnome-www-browser /etc/push/push.html
	if [ $? = "0" ] ; then
	echo "the browser opened at $(date)" >> modification.log
	echo "NOTIFICATION SENT SUCESSFULLY"
	echo "notification sent at $(date)"
	rm fei
	else
	echo "we could not open anything :v $(date)" >> modification.log
	rm fei
	fi
	else
        echo "there is no change in the official page at $(date)"
	rm fei
	fi
fi
