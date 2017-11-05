#!/bin/bash
#Script created by jesus rosas to allow you
#to have a distibution though to be usefull for
#the career of networks and computer services from
#universidad veracruzana
echo "removing useless shorcuts"
rm /usr/share/applications/ubuntu-amazon-default.desktop
rm /usr/share/unity-webapps/userscripts/unity-webapps-amazon/Amazon.user.js
rm /usr/share/unity-webapps/userscripts/unity-webapps-amazon/manifest.json
echo "creating defautl directories"
mkdir  "/etc/skel/Tareas"
mkdir  "/etc/skel/Projectos"
mkdir  "/etc/skel/Programas"
mkdir  "/etc/skel/Anime"
mkdir  "/etc/skel/Canciones"
mkdir  "/etc/skel/Videos"
mkdir  "/etc/skel/Fotos"
mkdir  "/etc/skel/Libros-PDF"
mkdir  "/etc/skel/Juegos"
mkdir "/opt/Documentos-De-Redes"
mv *.pdf //opt/Documentos-De-Redes
ln -s /opt/Documentos-De-Redes /etc/skel/Documentos-De-Redes
echo "CREATING OPTATIVE DIRECTORIES"
mkdir  "/opt/games"
mv "Katawa Shoujo-1.3.1-linux" /opt/games
echo "SETTING NEW BACKGROUND IMAGE"
mv warty-final-ubuntu.png /usr/share/backgrounds/
echo "CHANING STARTUP SOUND"
mv  desktop-login.ogg /usr/share/sounds/ubuntu/stereo/
echo "INSTALLING PUSH NOTIFICATIONS"
mkdir /etc/push/
touch /etc/push/notifications
touch /etc/push/modification.log
chmod 666 notifications
chmod 666 modification.log
chmod 666 push.html
mv push.js /etc/push/
mv push.html /etc/push/
mv push-notifications.sh /etc/push/
mv uv.desktop /usr/share/applications/
echo "INSTALLING PACKET TRACER"
mv packet.desktop /usr/share/applications
echo "updating all the necesary packages ..."
aptitude update
aptitude install -y eclipse
aptitude install -y mpv
aptitude install -y codeblocks
aptitude install -y gnuradio
aptitude install -y octave
aptitude install -y dia
aptitude upgrade -y firefox
aptitude upgrade -y libreoffice
echo "cleaning everything"
aptitude autoclean
aptitude clean
echo "done!"
