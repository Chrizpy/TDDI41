#!/bin/bash
RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

point=$(df | fgrep usr/local | wc -l)

if [ ! $point == "0" ]
then
	:
else
	echo -e "NFS: ${RED}Failed${NC} - Failed to mount /usr/local"
fi

sshpass -p "sysinst" ssh root@10.0.0.2 showmount -e > moont

if [ `cat moont | fgrep home | wc -l` > 1 ]
then
	:
else
	echo $EXPORTS
	echo $EXPORTS
	echo -e "NFS: ${RED}Failed${NC} - /home1 or /home2 is not exported"
	exit 1
fi  

rm moont
sshpass -p "test" ssh lida2@10.0.0.3 touch foo
sshpass -p "test" ssh lida1@10.0.0.3 touch foo

temp1=$(ls /home/lida1 | grep -c foo)
temp2=$(ls /home/lida2 | grep -c foo)

if [ $temp1 == "1" ] && [ $temp2 == "1" ] 
then 
        sshpass -p "test" ssh lida1@10.0.0.3 rm /home/lida1/foo 
        sshpass -p "test" ssh lida2@10.0.0.3 rm /home/lida2/foo
	echo -e "NFS: ${GREEN}Pass${NC}" 
else 
        echo -e "NFS: ${RED}Failed${NC} - Permission error"
fi

