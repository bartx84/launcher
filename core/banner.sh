#!/bin/bash
#universal and modular bash application launcher
#https://github.com/bartx84/launcher
#bartx [at] mail.com
#
#core library
#Header banner

#define workdir
workdir=$(pwd)
#import the global functions library
. $maindir/core/glb_functions.sh

#import the required libraries
import_lib globals.sh colors.sh net_functions.sh

function print_banner()
{
myst=""
clear 
echo -e "${WHITE_ON_GREEN}$(regolarize_names Disk: 15)$(disk_info /)\t\t$(regolarize_names Ram: 15)$(ram_info)${NC}"
echo -e "$(regolarize_names $eth status: 25)$(on_off_color $(interface_status $eth))\t\t$eth IP: ${YELLOW}$(interface_ip $eth)${NC}"
echo -e "$(regolarize_names $wlan status: 25)$(on_off_color $(interface_status $wlan))\t\t$wlan IP:${YELLOW}$(interface_ip $wlan)${NC}"
echo -e "$(regolarize_names EXT. IP: 13)${YELLOW}$(externalip)${NC}\t\tMonitor Mode on $mon:$(on_off_color $(interface_status $mon))"
echo -e "\e[1;32m       _                        _               "
echo -e "      | | __ _ _   _ _ __   ___| |__   ___ _ __ "
echo -e "      | |/ _' | | | | '_ \ / __| '_ \ / _ \ '__|"
echo -e "      | | (_| | |_| | | | | (__| | | |  __/ |   "
echo -e "      |_|\__,_|\__,_|_| |_|\___|_| |_|\___|_|   "
echo -e "                       version $(convert_version $(cat $maindir/version)) by bartx ${NC}"
echo -e "                       http://github/bartx84/launcher"
echo -e " "
}


