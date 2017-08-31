#1/bin/bash
#Desarrolado por jesus Antonio Rosas Percastre
echo "introduce el nombre completo del archivo a recuperar";
read  rec
echo "estas seguro? (s/n)"
read ans
#path=`pwd`;
if [  $ans = "s"  -o  $ans = "S" ] ; then
	echo "Tratando de recuperar el archivo $rec ..."
	cd /home/$USER/.TrashUsers/
	mv ".$rec" "$rec" && mv "$rec" ~
#	mv "/home/.TrashUsers/.$rec $rec"  && mv "/home/.TrashUsers/$rec" "$path"
	if [ $? -eq 0 ] ; then
	echo "El archivo se ha recuperado en el directorio $HOME"
	exit 0;
	else
	echo "Un problema Ocurrio al recuperar el archivo $rec"
	exit 1;
	fi
else
	echo "pues no lo recupero y ya :'v"
	echo "no es como que quisiera recuperarlo :v"
	exit 0;
fi
