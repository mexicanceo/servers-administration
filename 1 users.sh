#!/bin/bash
#this was developed by jesus Rosas
#version 1 this version only creates users
#shell="/bin/bash"
opc=""
while [ "$opc" != "9" ] ; do 
echo "1 create an user"
echo "2 Delete an user"
echo "3 create a group"
echo "4 delete a group"
echo "5 change username name"
echo "6 change a shell for a user"
echo "7 change home directory for a certain user"
echo "8 change group for a certain group "
echo "9 exit "
read opc
case $opc in
	"1")
echo "welcome to our system" 
echo  "introduce the name of your new user"
read user
echo "Please introduce your password"
read -s  original
echo -e  "confirm your password"
read -s  second
echo "first lenght $original ${#original} "
echo "second length $second  ${#second}"

if [ "$original" = "$second" -a ${#original} -gt 8 -a ${#second} -gt 8  ] ; then 
	echo  "the password are the same correct!"
	groupadd $user
	echo "group $user created sucessfully"
	useradd -m -d /home/$user  -k /etc/skel -c "new user" "-g" $user -s /bin/bash $user
	echo "$user":"$original" | chpasswd -c SHA512
	echo "######################################"
	echo "your user has been sucessfully created"
	echo "Information about your user -> "
	echo "Name: $user"
	echo "Base DIrectory: /home/$user"
	echo "Shell : /bin/bash"
else
	echo  "an error has ocurred"
	echo "the password does not follow the policies"
fi
	;;
	"2")
	echo "read the user to delete"
	read user
	deluser $user
	rm -rf /home/$user
	;;
	"3")
	echo "type the group to add"
	read group
	groupadd $group
	;;
	"4")
	echo "type the group to delete"
	read group
	delgroup "$group"
	;;
	"5")
	echo "Type your current login name"
	read old
	echo "type yor new login name "
	read new
	usermod -l $new $old
	;;
	6)
	echo "type the user to change the shell"
	read user
	echo  "type the shell to change"
	read shell
	var=`which "$shell"`
	if [ $? -eq 0 ] ; then
	chsh -s "$var" "$user"
	else
	echo -e "the interpreter does not exist \nverify this before setting it"
	fi
	;;
	7)
	echo "Type the user to change the directory"
	read user
	echo -e "type the absolute path for the directory\n By Default creates the directory"
	read directory
	usermod -m -d "$directory" "$user"
	echo "the user $user has the following directory $directory"
	;;
	8)
	echo "type the user to change the user"
	read user
	echo "change user's "
	read group
	usermod "-g" "$group" "$user"
	usermod -a -G "$group" "$user"
	echo "the group has been successfully changed"
	;;
	9)
	echo "Thanks for using my software"
	;;
	*)
	echo "the option is not valid";;
	esac
done
