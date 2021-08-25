#!/bin/sh

/app/tailscale up --authkey=${TAILSCALE_AUTHKEY} --hostname=cloudrun-app
do
    sleep 0.1
done
echo Tailscale started
