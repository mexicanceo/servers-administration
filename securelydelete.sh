#1/bin/bash
#Desarrollado Jesus Antonio Rosas Percastre
function borrar {
 		echo "Borrando el archivo $del"
                mv $del ".$del" && mv ".$del" /home/$USER/.TrashUsers
                if [ $? -eq 0  ] ; then 
                echo "El archivo se borro exitosamente!"
                exit 0;
                else
                echo "Error al borrar el archivo!"
                exit 1;
                fi
}

echo "introduce el archivo con ruta completa";
read  del
echo "estas seguro? (s/n)"
read ans
if [ $ans = "s" -o $ans = "S" ] ; then
	if test ! -d /home/$USER/.TrashUsers/ ; then
		mkdir -p /home/$USER/.TrashUsers/
		borrar;
	else
		borrar;
	fi
else
	echo "No se borrara nada :'v "
	echo "no es como que quisiera borrarlo >:v"
	exit 0;
fi


