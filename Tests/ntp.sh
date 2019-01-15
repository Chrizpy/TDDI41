#!/bin/bash

RED='\033[1;31m'
NC='\033[0m'
GREEN='\033[1;32m'

HOST=$(hostname)

#echo "test #1 - check current ntp server"

if [ $HOST == "gw" ]
then
	if [[ ! `ntpq -p | grep "kakofonix" | cut -c 1` == '*' ]]
	then
		echo -e "$HOST: ${RED}fail${NC}\nDoes not have kakofonix as current"
		exit 1
	fi
fi

if [ ! $HOST == "gw" ]
then
	if [[ ! `ntpq -p | grep "lida" | cut -c 1 ` == "*" ]]
	then
		echo -e "$HOST: ${RED}fail${NC}\nDoes not have lida as current"
		exit 1
	fi
fi

echo -e "NTP: ${GREEN}Pass${NC}"
