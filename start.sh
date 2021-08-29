#!/bin/sh

command='/usr/bin/tailscale up'

#advertise-routes
if [[ -z "${ROUTE}" ]]; then
  echo "No Route set..."
else
  command="${command} --advertise-routes ${ROUTE}"
fi

if [[ -z "${AUTHKEY}" ]]; then
  echo "No Auth Key Specified"
else
  command="${command} --authkey ${AUTHKEY}"
fi


sleep 5 && eval $command 2>&1 &
/usr/bin/tailscaled
