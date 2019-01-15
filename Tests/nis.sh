#!/bin/bash
RED='\033[1;31m'
GREEN='\033[1;32m'
NC='\033[0m'

NIS_SERVER=$(ypwhich)
NIS_CLIENT=$(whoami)

if [ `ypwhich | grep -c group.lida.se` == "1" ]
then
	:	
else
echo -e "NIS: ${RED}Failed${NC} - Failed to find correct NIS server"
exit 1 
fi

if [ `ypcat passwd | fgrep $NIS_CLIENT | wc -l` -ne 0 ]
then
	echo -e "NIS: ${GREEN}Pass${NC}"
else
	echo -e "NIS: ${RED}Failed${NC}"
fi

