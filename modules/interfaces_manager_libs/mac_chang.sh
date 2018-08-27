#!/bin/bash
#net_functions.sh
#Author bartx <bartx @ mail.com>

function change_mac()
{
if [ "$2" = "-m" ]
then 
echo -e "Please digit the MAC address [XX:XX:XX:XX:XX:XX]"
mac=
read mac
option="-m $mac"
else
option=$2
fi
ifconfig $1 down
macchanger $option $1
ifconfig $1 up
}

function changemacmenu()
{
clear
echo -e "${RED}Please select an option${NC}"
echo -e "[1] - Insert a manual MAC address [XX:XX:XX:XX:XX:XX] "
echo -e "[2] - Don't change the vendor bytes"
echo -e "[3] - Set random vendor MAC of the same kind"
echo -e "[4] - Set random vendor MAC of any kind "
echo -e "[5] - Set fully random MAC"
echo -e "[6] - Reset to original, permanent hardware MAC"
echo -e ""
echo -e "${YELLOW}[b] - Back to interface manager${NC}"

selection=
until [ "$selection" = "b" ]; do
  read selection
  echo ""
  case $selection in
   
  1 ) change_mac $maciface -m;clear;wifii_menu;;
  2 ) change_mac $maciface -e;clear;wifii_menu;;
  3 ) change_mac $maciface -e;clear;wifii_menu;;
  4 ) change_mac $maciface -A;clear;wifii_menu;;
  5 ) change_mac $maciface -r;clear;wifii_menu;;
  6 ) change_mac $maciface -p;clear;wifii_menu;;
  
  b ) wifii_menu;;
  * ) echo -e "Invaliid command"
  esac
done
}
