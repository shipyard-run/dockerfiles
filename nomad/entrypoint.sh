#!/usr/bin/env bash
# Keep DNS intact if we are not running supervisord & as such consul
if [[ "x$1" == "x/usr/bin/supervisord" ]]; then
    ip addr add dev eth0 169.254.1.1
    echo -n "recursors = " > /etc/consul.d/config/00_recursors.hcl
    echo $(grep -E '^nameserver ' /etc/resolv.conf|cut -f 2 -d " "|jq -cnR '[inputs | select(length>0)]') >> /etc/consul.d/config/00_recursors.hcl
    echo "$(grep -vE '^nameserver ' /etc/resolv.conf)" > /etc/resolv.conf
    echo "nameserver 169.254.1.1" >> /etc/resolv.conf
fi
exec "$@"
