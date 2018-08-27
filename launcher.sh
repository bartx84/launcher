#!/bin/bash
#universal and modular bash application launcher
#https://github.com/bartx84/launcher
#bartx [at] mail.com

#define main dir
maindir=$(pwd)

#import the global functions library
. $maindir/core/glb_functions.sh

#import the required libraries
import_lib update.sh globals.sh colors.sh net_functions.sh banner.sh themes.sh

export PATH=$PATH:$workdir/modules/


#array and variables declaration
declare -a directory
declare -a file_men
declare -a actions
declare -a parameters

#Check user for root
if [ $USER != 'root' ]; then
	echo "You must be root to execute the script!"
	exit
fi 
path_register
import_net_interfaces_options

function list_directory() {
myworkdir=$1
cd $myworkdir

count=0
        for i in $( ls -d */)
        do
			declare -a dirs
			declare -a menudirs
			dirs=( `echo "$i" | tr '/' '\n'`)
			dirname=${dirs[0]}
			directory[$count]=$dirname
			menudirs=( `echo "$dirname" | tr '-' '\n'`)
			dirmen=${menudirs[1]}
			echo -e "[$count] - $dirmen"
			let count=count+1
        done
        echo ""
        newversion=$(update_checker)
        if [ "$newversion" != "noupdate" ]
        then 
        echo -e "${YELLOW}[u] - New version of launcher available [$(convert_version $newversion)] press u to update${NC}"
        fi
        echo -e "${RED}[e] - Exit${NC}"
        echo ""
		echo -e -n "Enter selection:"
}

function list_apps() {
 declare -a gettitle
 apworkdir=$1
 cd $apworkdir
 gettitle=( `echo "$apworkdir" | tr '-' '\n'`)
 title=${gettitle[1]}
 echo -e "${RED}\t\t$title${NC}"
 echo ""
 count=0
			 for i in $( ls )
			 do
			 declare -a filesmenu
			 declare -a commands
			 filename=( `echo "$i"`)
			 file_men[$count]=$filename
			 commands=( `cat "$filename" | tr ';' '\n'`)
			 actions[$count]=${commands[0]}
			 parameters[$count]=${commands[1]}
			 filesmenu=( `echo "$filename" | tr '-' '\n'`)
			 printfilename=${filesmenu[1]}
			 echo "[$count] - $printfilename"
			 let count=count+1
			 done
		 echo ""
		 echo -e "${YELLOW}[b] - back to main menu${NC}"
		 echo ""
		 echo -e -n "Enter selection:"
 }
 
 
function main_menu() {
get_current_theme
print_banner
list_directory $current_theme

tLen=${#directory[@]}

			until [ "$selection" = "e" ]; do
			  read selection
			  re='^[0-9]+$'
			  if [ "$(update_checker)" != "noupdate" ]	&& [ "$selection" = "u" ]
			  then
			  clear
			  get_update			  
			  elif ! [[ $selection =~ $re ]] 
			  then
			  clear
			  print_banner
			  list_directory "$current_theme"
			  elif  (("$selection" < "${tLen}"))
			  then target_directory=${directory[$selection]}
			  clear
			  apps_menu $target_directory
			  else
			  clear
			  print_banner
			  list_directory $current_theme
			  fi  
			done
}

function apps_menu() {
current_dir=$1
print_banner
list_apps $current_dir
tLen=${#file_men[@]}
			until [ "$selection" = "e" ]; do
			  read selection
			  re='^[0-9]+$'
			  if [ "$selection" == "b" ]
			  then   clear
			  print_banner
			  main_menu
			  elif ! [[ $selection =~ $re ]] 
			  then
			  clear
			  print_banner
			  cd ..
			  list_apps $current_dir
			  elif  (("$selection" < "${tLen}"))
			  then 
			  clear
			  execute ${actions[$selection]} $current_dir ${parameters[$selection]} 
			  else
			  clear
			  print_banner
			  list_apps $current_dir
			  fi  
			 done
}

function execute() {
if [ -n $3 ]
then 
declare -a optionss
optionss=( `echo "$3" | tr ',' '\n'`)
opt=""

for i in "${optionss[@]}"
do
   :
   declare -a arguments
   arguments=( `echo "$i" | tr '.' '\n'`)
   echo "Please insert ${arguments[0]}"
   read target
   opt="$opt ${arguments[1]} $target"
   done
fi 
  
 (exec $1 $opt)
  opt="" 
  wait $!  
  clear
  echo "Press enter to return to launcher"
  read back
  if [ "back = b" ]
  then   clear
  print_banner
  cd ..
  apps_menu $2 
  else
    clear
  print_banner
  cd ..
  apps_menu $2 
  fi
  
}	

function check_arg() {
if [ $# -eq 0 ]; then
main_menu
exit 1
fi
}

check_arg $@
if [ "$1" == "-g" ] && [ "$2" != "" ]  
then
download_theme $2
fi
if [ "$1" == "-t" ] 
then
merge_all_themes
fi
exit





