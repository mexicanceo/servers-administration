#!/bin/bash
#"Program created to Jesus Rosas"
#"Available in github at -> "
echo "Hello pal and welcome to DiscoWget 1.0"
echo "Program created to download relevant information"
red=`tput setaf 1`
green=`tput setaf 2`
#"Sites tested!"
#site to scan "www.uv.mx/"
#site to scan "www.uv.mx/fei"
#site to scan "www.uv.mx/dgti"

#"1 Links the webpage references -> (sql,js,docx,pdf)"
#"2 Facebook references"
#"3 Twitter references"
#"4 Mail references"
#"5 Selected words -> (password,contraseña)"
#"6 Address -> (Calle,colonia)"
#"7 IP Addresses"
#"8 Comments"

#"$1 = web page $2 output file $3 path to place the file"

download_file(){
        echo "Downloading file $1 into $2"
        echo "time Taken to download the file"
        echo "Parameters passed $@"
        time  wget  -c --user-agent 'Mozilla/5.0' -q --https-only --secure-protocol=TLSv1_2  $1 --output-document=$3/$2  2> /dev/null
        #time  wget -c --https-only --secure-protocol=TLSv1_2  $1 --output-document=$3/$2  2> /dev/null
        if [ $? -eq 0  ] ; then
        echo "File Downloaded Sucessfully"
	echo "STARTING the analysis at $($date)"
	echo "${green}------------1 Getting the URL associated--------------" >> report.txt
	echo "GENERAL REPORT FOR THE WEB PAGE $1" >> report.txt
	cat $2 | grep href | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep http >> report.txt
	echo "${red}--------Getting sites starting with www-----------------" >> report.txt
	cat $2 | grep href | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep www | sed 's/^\/\///g' | grep ^www >> report.txt
	#"cat index.html | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep www | sed 's/src=//g' >> report-$1.txt" 
	#"cat index.html | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep www | sed 's/src=//g' | sed 's/srcset=//g'>> report-$1.txt" 
	echo "${green}2- Getting Facebook References!" >> report.txt
	cat $2 | grep href | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep http | grep facebook >> report.txt
	echo "${red}-------------------3 Getting twitter References!----------------" >> report.txt
        cat $2 | grep href | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep http | grep twitter >> report.txt
	echo "${green}4 --------LOOKING FOR MAILS OR TWITTER!------" >> report.txt
	echo "${green}Twitter" >> report.txt
	cat $2 | grep href | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' |   grep @ | uniq >> report.txt
	echo "${red}---------------Mails---------------------------" >> report.txt
	cat $2 | grep href | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | sed 's/</\//g'  |  grep mailto >> report.txt
	echo "${red}------------5 Selected words-------------------" >> report.txt
	cat $2 | grep href | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep nomina >> report.txt
	cat $2 | grep href | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep password >> report.txt
	sed -e 's/<[^>]*>//g' $2 | grep password >> report.txt
	sed -e 's/<[^>]*>//g' $2 | grep Xalapa >>  report.txt
	echo "${green}---------6 Loooking for web words Addrees------" >> report.txt
	cat $2 | grep href | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep calle >> report.txt
	cat $2 | grep href | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep correo >> report.txt
	cat $2 | grep href | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep avenida >> report.txt
	cat $2 | grep href | sed 's/href=//g' | sed 's/"//g' | tr ' ' '\n' | grep tamaño >> report.txt
	echo "${red}-----------7 IP ADDRESSES FOUND ${red}-------------" >> report.txt
	cat $2  | tr ' ' '\n'  | grep [0-9].[0-9].[0-9].[0.9]* >> report.txt
	echo  "${green}------------8 COMMENTS FOUND---------------------" >> report.txt
        cat $2 | grep '<!--*-->' >> report.txt
	echo "${red}Analysis done at $(date)" >> report.txt
	echo "CHECK THE FILE!"
        return 0
        else
        echo "We could not download anything"
        return 1
        fi
}
download_file $1 $2 $3

