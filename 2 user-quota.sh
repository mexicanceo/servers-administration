#!/bin/bash
#this was developed by jesus Rosas
#version 2 with definition of quotas
#beware that the quotas are aplied to the file system you choose

opc=""
while [ "$opc" != "12" ] ; do 
echo "1 create an user"
echo "2 Delete an user"
echo "3 stablish a disk quota for a certain user"
echo "4 check all the quotas for all the users"
echo "5 check the quota for a specific user"
echo "6 create a group"
echo "7 delete a group"
echo "8 change username name"
echo "9 change a shell for a user"
echo "10 change home directory for a certain user"
echo "11 change group for a certain group "

echo "12 exit "
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

if [ "$original" = "$second" -a ${#original} -gt 3 -a ${#second} -gt 3  ] ; then 
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
	echo -e "an error has ocurred \nplease write a secure password"
fi
	;;
	"2")
	echo "read the user to delete"
	read user
	deluser $user
	rm -rf /home/$user
	;;
	"3")
	echo "type the file system that implements the quota  (example) /home"
        read fsys
        echo "type the name of the user"
        read user
        echo "type soft limit  for the quota space (The space must be grater than 0) in MB"
        read soft
        echo "type hard limit  for the quota space (The space must be grater than 0) in MB"
        read hard
        quotatool -u $user -bq "$soft Mb" -l "$hard Mb" $fsys
        echo "Quota stablished sucessfully for the user $user"
        echo "File system: $fsys "
        echo "Soft limit: $soft MB"
        echo "Hard limit: $hard MB"
        echo "quota stablished at $(date)"
	;;
	"4")
	echo "List of all the quotas for the users"
        repquota -as
        echo "queried at $(date)"
	;;
	"5")
	echo "type the username to see the quota"
        read user
        quota -us $user
        echo "queried at $(date)"
	;;
	"6")
	echo "type the group to add"
	read group
	groupadd $group
	;;
	"7")
	echo "type the group to delete"
	read group
	delgroup "$group"
	;;
	"8")
	echo "Type your current login name"
	read old
	echo "type yor new login name "
	read new
	usermod -l $new $old
	;;
	"9")
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
	"10")
	echo "Type the user to change the directory"
	read user
	echo -e "type the absolute path for the directory\n By Default creates the directory"
	read directory
	usermod -m -d "$directory" "$user"
	echo "the user $user has the following directory $directory"
	;;
	"11")
	echo "type the user to change the user"
	read user
	echo "change user's "
	read group
	usermod "-g" "$group" "$user"
	usermod -a -G "$group" "$user"
	echo "the group has been successfully changed"
	;;
	"12")
	echo "Thanks for using my script"
	;;
	
	*)
	echo "the option is not valid";;
	esac
done
