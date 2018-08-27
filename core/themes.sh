#!/bin/bash
#universal and modular bash application launcher
#https://github.com/bartx84/launcher
#bartx [at] mail.com
#
#core library
#themes library

#import the global functions library
. $maindir/core/glb_functions.sh

function get_current_theme() {
mypth=$(pwd)
if [ -e "$theme_file" ]
then
my_theme_path=( `cat "$theme_file"`)  
	if [ $my_theme_path != "" ] && [ -e "$themes_dir/$my_theme_path" ]
	then
	current_theme=$(echo "$themes_dir/$my_theme_path")
	else
	cd $themes_dir
	echo "base" > current.conf
	cd $mypth
	current_theme=$(echo "$themes_dir/base/")
	fi
else
	cd $themes_dir
	echo "base" > current.conf
	cd $mypth
current_theme=$(echo "$themes_dir/base/")	
fi
}

function reload_current_theme() {
mypth=$(pwd)
cd $themes_dir
echo $current_theme > current.conf
cd $mypth
}


function get_theme_name() {
declare -a themesource
themesource=( `echo "$1" | tr '/' '\n'`)
tLen=${#themesource[@]}
namepos=$(($tLen-1))
themename=${themesource[$namepos]}
echo "$themename"
}




function download_theme() {
themename=$(get_theme_name $1)
echo "installing $themename theme"
cd $themes_dir
git clone $1
merge_theme $themename
echo $themename > current.conf
echo "Theme $themename installed"
}


function merge_theme() {
echo -e "${RED}installing launcher basic commands in $1 theme${NC}"
cp -r base/* $1
echo -e "${GREEN}Done${NC}"
}


function merge_all_themes() {
	echo -e "${RED}UPGRADE LAUNCHER BASIC COMMANNDS IN ALL INSTALLED THEMES${NC}"
	cd $themes_dir
        for i in $( ls -d */)
        do
			dirs=( `echo "$i" | tr '/' '\n'`)
			dirname=${dirs[0]}
			if [ $dirname != "base" ]
			then
			merge_theme $dirname
			fi
        done
	echo -e "${GREEN}ALL INSTALLED THEMES UPGRADED${NC}"
	echo -e ""
	echo -e "${YELLOW}PRESS ENTER TO RETURN TO LAUNCHER${NC}"
}
