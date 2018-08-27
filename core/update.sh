#!/bin/bash
#universal and modular bash application launcher
#https://github.com/bartx84/launcher
#bartx [at] mail.com
#
#core library
#update library

#import the global functions library
. $maindir/core/glb_functions.sh

#import the required libraries
import_lib themes.sh

function update_checker() {
extip=$(curl -s http://whatismyip.akamai.com/)
if [ "$extip" != "" ] 
then  
currentversion=$(cat "$workdir/version")
wget https://raw.githubusercontent.com/bartx84/launcher/master/version -O /tmp/launcher_up 2>/dev/null
wait $!
if [ -e "/tmp/launcher_up" ]
then
newversion=$(cat "/tmp/launcher_up")
else 
newversion=""
fi

	if [ "$newversion" -gt "$currentversion" ] &&  [ "$newversion" != "" ]
	then 
	echo "$newversion"
	else 
	echo "noupdate"
	fi
else 
echo "noupdate"
fi

if [ -e "/tmp/launcher_up" ]
then
rm /tmp/launcher_up
fi
}

function get_update() {
get_current_theme
echo -e "${RED}UPDATE IN PROGRESS${NC}"
git reset --hard origin/master
git pull origin master
echo -e "${GREEN}UPDATE COMPLETE${NC}"
echo -e ""
merge_all_themes
reload_current_theme
}













