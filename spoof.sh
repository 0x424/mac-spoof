#!/bin/bash
if [ "$EUID" -ne 0 ]
  then echo "youre not root"
  exit
fi
oldad=$(ifconfig en0 |grep ether)
echo "Your current mac address: "
printf $oldad
echo "spoof? [y,n]"
read input
if [[ $input == "Y" || $input == "y" ]]; then
		newad=$(openssl rand -hex 6 | sed 's/\(..\)/\1:/g; s/.$//')
		command sudo ifconfig en0 ether $newad
		echo "changed from "
		printf $oldad
		echo " to "
        printf $newad
else
        echo "exit"
fi