#!/bin/sh
# this clears stale tunnels when there is no equivalent connection
# change the username@ with the tunnel username on the remote system you use
# I run this out of cron
# */5 * * * * /usr/local/bin/monitor-autossh-tunnel.sh 1>/dev/null 2>&1
sshpid=$(ps auxww | grep username@ | grep /ssh | awk '{ print $2 }')

if [ -z "$sshpid" ]; then
  exit 0
fi

lsofout=$(lsof -n -P -p $sshpid 2> /dev/null | grep TCP)

if [ -z "$lsofout" ]; then
  kill -9 $sshpid
fi

exit 0
