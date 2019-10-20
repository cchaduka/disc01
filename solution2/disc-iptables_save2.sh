#!/bin/bash

CHKVERFILE="/etc/redhat-release"
IPTABLESCFG="/etc/sysconfig/iptables"
RHVER=$(awk '{print $7}' ${CHKVERFILE} | awk -F"." '{print $1}')

if [ ! -f ${IPTABLESCFG} ];	then
	echo "File ${IPTABLESCFG} does not exist!"; exit;
fi

if [ ${RHVER} = 7 ]
	then
		exit;
else
	if [ ${RHVER} = 6 ]
		then
			# Check modification
			UNIXTIMENOW=$(date +%s)
			echo "Time now is ${UNIXTIMENOW}"
			
			#Format UNIXTIMENOW to find execution hour
			SCRPTEXEHR=$(date -d @"${UNIXTIMENOW}" | awk '{print $4}' | awk -F":" '{print $1}')
			echo "Hour this script is executing is: ${SCRPTEXEHR}"; echo
			
			CFGLSTMODTIME=$(stat -c %y ${IPTABLESCFG} | awk -F"." '{print $1}')
			CFGLSTMODTIMESTMP=$(date --date="${CFGLSTMODTIME}" +"%s")
			echo "Conf file timestamp is: ${CFGLSTMODTIMESTMP}"
			FILEAGE=$(( (${UNIXTIMENOW} - ${CFGLSTMODTIMESTMP}) ))
			
			echo "File age is: ${FILEAGE} seconds"
			
			if [ ${FILEAGE} -gt 60 ] && ([ ${SCRPTEXEHR} = "07" ] || [ ${SCRPTEXEHR} = "17" ])
				then
					echo "Updating iptables config file"; echo
					/sbin/iptables-save > ${IPTABLESCFG}
			else
				echo "Not updating iptables config file. Either it has been updated less than an hour ago or current hour (${SCRPTEXEHR}) doesn't permit this action."
			fi
			
	fi
fi