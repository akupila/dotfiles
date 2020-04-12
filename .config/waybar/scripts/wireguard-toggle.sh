#!/usr/bin/bash

set -e

INSTANCE="i-09d981cf15bd2a94e"

if ip a | grep -q 'wg0'; then
    sudo wg-quick down wg0
    aws ec2 stop-instances --instance-ids $INSTANCE > /dev/null
else
    aws ec2 start-instances --instance-ids $INSTANCE > /dev/null
    sudo wg-quick up wg0
    echo "Waiting for connection.."
    while true; do
        curl -s google.com > /dev/null && break;
    done
fi

