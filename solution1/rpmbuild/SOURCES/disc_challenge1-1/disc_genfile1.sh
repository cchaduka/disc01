#!/bin/bash

# Create a file /etc/challenge
#
# Find out what this hostname is
THISHOST=`hostname`

#What is the current date / time
DATETIMENOW=`date`

echo "Hostname is: ${THISHOST}"; echo
echo "Current date/time is: ${DATETIMENOW}"
