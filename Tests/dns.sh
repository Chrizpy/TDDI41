#!/bin/bash

names=(gw server client-1 client-2)

RED='\033[1;31m'
NC='\033[0m'
GREEN='\033[1;32m'

#echo -e "test #1 - authoritative answer"
for i in ${names[@]}; do
auth=$(dig +norecurse $i.group.lida.se | awk '/flags: /' | grep -o "aa")
if [ ! $auth == "aa" ]
then
	echo -e "$i: ${RED}fail${NC} - answer is not authoritative"
	exit 1
fi
done

#echo -e "test #2 - recursive answer"
auth=$(dig @10.0.0.2 www.google.se | awk '/flags: /' | grep -co "ra")
if [ ! $auth == "1" ]
then
	echo -e "${RED}fail${NC} - answer no recursive from own network"
	exit 1
fi

#echo -e "test #3 - reverse lookup"

names=(gw ns client-1 client-2)

for value in {1..4}
do
target1="${names[$value-1]}.group.lida.se."
target2="10.0.0.$value"

host=$(dig +noall +answer -x 10.0.0.$value | grep -co $target1)
ipad=$(host ${names[$value-1]} | grep -co $target2)

if [ ! $host == "1" ]
then
echo -e "${names[$value-1]}: ${RED}fail${NC} - dig resolved incorrectly"
exit 1
else
	if [ ! $ipad == "1" ]
	then
	echo -e "${names[$value-1]}: ${RED}fail${NC} - host resolved incorrectly"
	exit 1
	fi
fi

done

echo -e "DNS: ${GREEN}Pass${NC}"
