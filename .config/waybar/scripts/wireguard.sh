#!/usr/bin/bash

echo "vpn"
if [[ "$(pgrep -x wg-crypt-wg0)" -eq 0 ]]; then
    echo "Disabled"
    echo "disabled"
else
    echo "Enabled"
    echo "enabled"
fi

