#!/bin/bash
#"Colors!"
red=`tput setaf 1`
green=`tput setaf 2`
yellow=`tput setaf 3`
color=`tput setaf 4`

echo "Variables!"
FILE='ciscogear.log'
declare -i LINES=$(cat ciscogear.log | wc -l)
echo "Creating a friendly format given a cisco log at $(date)"
echo "Overall Lines $LINES"
for (( i = 1; i <= "$LINES"; i++ )); do
echo "-------Logs-------------|"
echo "${green}|Action Number -> $i|"
echo "|Cisco Interface -> $(cat $FILE | tr ' ' '\n' | grep Giga | sed -n "$i p" )|"
echo "|Server LOG IP: -> $(cat ciscogear.log | tr ' ' '\n' | grep [0-9].[0-9].[0-9].[0-9] | sed -n "$i p"  )|"
echo "${yellow}|Cisco Message: -> ${red} $(cat ciscogear.log | tr ' ' '\n' | grep % | sed -n "$i p" )|"
echo "|${color}Format generated at $(date)|"
echo "--------------------|"
done

#echo "KILLER EXPRESSION"
#awk '{print $1; exit}' ciscogear.log 
#"INTERFACE"
#sed -n  '2p' ciscogear.log |  awk '{print $11; exit}'
#tr ' ' '\n' 
#printing the specific date
#"cat ciscogear.log | tr ' ' '\n' | grep : | grep -v %"

