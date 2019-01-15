#!/bin/bash

name=$(</etc/hostname)
line=$(hostname)
RED='\033[1;31m'
NC='\033[0m'
GREEN='\033[1;32m'

#echo "test #1 - hostname"
if [ ! $name = $line ];
then
	echo -e "${RED}Fail${NC} - wrong hostname"
	exit 1
fi

#echo "test #2 - ping outside host"

if ! ping -c 1 8.8.8.8 &> /dev/null
then
echo -e "${RED}Fail${NC} - could not reach host"
exit 1
fi

#echo "test #3 - test name resolution"

if ! ping -c 1 remote-und.ida.liu.se &> /dev/null
then
echo -e "${RED}Fail${NC} - could not reach host"
exit 1
fi

echo -e "NET: ${GREEN}Pass${NC}"
