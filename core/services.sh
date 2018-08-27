#!/bin/bash
#universal and modular bash application launcher
#https://github.com/bartx84/launcher
#bartx [at] mail.com
#
#core library
#service manager library

function service_status() {
sprocess=$(service $1 status | grep Active)
declare -a sdetails
sdetails=( `echo "$sprocess" | tr '        ' ' '`)  
serv_status=${sdetails[2]}
if [ "$serv_status" = "(running)" ] || [ "$serv_status" = "(exited)" ]
then
echo "ACTIVE"
elif [ "$serv_status" = "(dead)" ]
then
echo "STOPPED"
else 
echo "UNKNOWN"
fi
}

function service_action() {
if [ "$(service_status $1)" = "ACTIVE" ]
then
echo "stop"
elif [ "$(service_status $1)" = "STOPPED" ]
then
echo "start"
else 
echo "UNKNOWN"
fi
}









