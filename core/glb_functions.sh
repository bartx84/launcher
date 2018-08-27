#!/bin/bash
#universal and modular bash application launcher
#https://github.com/bartx84/launcher
#bartx [at] mail.com
#
#Core library
#globals functions library

function path_register() {
if [ -n $workdir/config ]
then 
mkdir $workdir/config
fi
echo $workdir > $workdir/config/maindir
echo $themes_dir > $workdir/config/themesdir
echo $theme_file > $workdir/config/currenttheme
}

function get_paths() {
levels=$1
for ((i=1; i<=levels; i++)); do
cd ..
done
maindir=$(cat "config/maindir")
themes_dir=$(cat "config/themesdir")
theme_file=$(cat "config/currenttheme")
}


function import_lib() {

for i in "$@"
do
:
mylib=$(echo $i)
. $maindir/core/$mylib
done
}

function disk_info() {
declare -a disk_data
disk=$(df -h $1)
disk_data=( `echo "$disk" | tr ' ' ' '`)  
disk_dim=${disk_data[9]}
disk_free=${disk_data[11]}


echo "$disk_dim Free:$disk_free"
}

function ram_info() {
declare -a ram_data
ram=$(free -h)
ram_data=( `echo "$ram" | tr ' ' ' '`)  
ram_dim=${ram_data[7]}
ram_free=${ram_data[9]}

echo "$ram_dim Free:$ram_free"
}

function convert_version() {

version=$1
[[ "$version" =~ ${version//?/(.)} ]] 
declare -a varr=( "${BASH_REMATCH[@]:1}" )
echo "${varr[0]}.${varr[1]}.${varr[2]}.${varr[3]}"
}

function regolarize_names() {
declare -a my_string
my_string=( "$@" )
stringlen=${#my_string[@]}
last=$(($stringlen -1))
exit_string=""

for ((i=0; i<$last; i++)); do
exit_string=$exit_string${my_string[$i]}" "
done
spaces_required=${my_string[$last]}
[[ "$exit_string" =~ ${exit_string//?/(.)} ]] 
declare -a varr=( "${BASH_REMATCH[@]:1}" )
tlenfile=${#varr[@]}				
			 spaces_needded=$(($spaces_required-$tlenfile))
			 spaces=""
				 for ((i=1; i<=$spaces_needded; i++)); do
				 spaces=$spaces" "
				 done 
				 echo "$exit_string$spaces"
}
