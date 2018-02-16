#!/bin/bash
#\n\ = salto de linea
#\t = tabulador
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
blue=`tput setaf 4`
color=`tput setaf 5`

while IFS=: read fecha1 equis dir fr event minut estIn
do echo -e "${green}Evento $event :\n ${blue}Fecha : $fecha1\n ${yellow}Dir IP :\t $dir \n ${color}Fecha Router :\t $fr $minut\n ${red}Estado de Interfaz :\t $estIn\n" 
done < ciscogear.log



