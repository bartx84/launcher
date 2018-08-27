#!/bin/bash
#universal and modular bash application launcher
#https://github.com/bartx84/launcher
#bartx [at] mail.com
#
#Core library
#network functions library

#Configure interfaces
function config_net_iterfaces () 
{
echo -e "${GREEN}Select the ethernet interface [eth0]${NC}"   
read eiface
if [ "$eiface" == "" ]
then
eiface="eth0"
fi	
	
echo -e "${GREEN}Select the wireless interface [wlan0]${NC}"   
read wiface
if [ "$wiface" == "" ]
then
wiface="wlan0"
fi

echo -e "${GREEN}Select the monitor interface [wlan0mon]${NC}"
read monint
if [ "$monint" == "" ]
then
monint="wlan0mon"
fi
  
 echo $eiface > $options_file
 echo $wiface >> $options_file
 echo $monint >> $options_file
 import_net_interfaces_options
 clear
 }


function import_net_interfaces_options () 
{
if [ -e "$options_file" ]
then
declare -a options
options=( `cat "$options_file" | tr '\n' ' '`)  
eth=${options[0]}
wlan=${options[1]}
mon=${options[2]}
#echo "config file exist"
 	else 
 	clear
 	echo -e "${RED}Config file missing, do you want create config file? (yes, no)[yes]${NC}"
	read mfo
		if [ "$mfo" == "yes" ]
		then 
		config_net_iterfaces
		fi
		if [ "$mfo" == "" ]
		then 
		config_net_iterfaces
		fi
fi
 }

function externalip() {
extip=$(curl -s http://whatismyip.akamai.com/)
if [ "$extip" = "" ] 
then  
echo "NO-IP\t"
else echo $extip
fi
}

function interface_status() {
2>/dev/null 1>&2 iwconfig > /tmp/$1
wait $! 
2>/dev/null 1>&2 ifconfig >> /tmp/$1
wait $!  
process2=$(cat /tmp/$1 | grep $1)
wait $! 
if [ -e /tmp/$1 ]
then 
rm /tmp/$1
fi

if [ "$process2" = "" ]
then wlanstatus="OFF"
else
wlanstatus="ON"
fi
echo $wlanstatus
}

function interface_ip() {
statusif=$(interface_status $1)
if [ "$statusif" = "ON" ]
then 
ip=$(ifdata -pa $1)
echo $ip
else
echo "NO-IP"
fi
}

function monitor_mode_check()
{
process=$(interface_status $mon)
declare -a details
details=( `echo "$process" | tr '        ' ' '`)  
on_off=${details[0]}
if [ "$on_off" = "OFF" ]
then monmenustatus="OFF"
monmenuitem="Enable monitor mode"
moncommand="sudo airmon-ng start $wlan"
elif [ "$on_off" = "ON" ]
then monmenustatus="ON"
monmenuitem="Disable monitor mode"
moncommand="sudo airmon-ng stop $mon"
else
monmenuitem="Monitor interface unknown"
moncommand=""
fi
}


function switch_interface()
{
process=$(interface_status $1)
declare -a details
details=( `echo "$process" | tr '        ' ' '`)  
on_off=${details[0]}
if [ "$on_off" = "OFF" ]
then intmenustatus="OFF"
echo "Enable $1:ifconfig $1 up"
elif [ "$on_off" = "ON" ]
then monmenustatus="ON"
echo "Disable $1:ifconfig $1 down"
else
echo="$1 status unknown:"
fi
}
