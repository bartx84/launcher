#!/bin/bash
#universal and modular bash application launcher
#https://github.com/bartx84/launcher
#bartx [at] mail.com
#
#core library
#Colors library

NC='\033[0m'
RED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
WHITE_ON_GREEN='\e[42m \e[1;37m '
CYAN="\033[1;36m"
MAGENTA="\033[1;35m"


function on_off_color() {
on_off_color=$1
if [ "$on_off_color" = "OFF" ]
then col_out="${RED}OFF${NC}"
elif [ "$on_off_color" = "ON" ]
then col_out="${GREEN}ON${NC}"
else
col_out="$on_off_color"
fi
echo $col_out
}
