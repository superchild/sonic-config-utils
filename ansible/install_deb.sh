#!/bin/bash

set -e

containers=('snmp'
            'radv'
            'dhcp_relay'
            'mgmt-framework'
            'nat'
            'lldp'
            'sflow'
            'stp'
            'telemetry'
            'syncd'
            'teamd'
            'iccpd'
            'swss'
            'pmon'
            'bgp'
            'database')

usage() {
cat << EOF
Usage: $0 <deb_file> <container>
EOF
}

if [ $# -ne 2 ]; then
    usage
    exit 1
fi

DEB_FILE=$1
CONTAINER=$2

if [[ ! " ${containers[@]} " =~ " ${CONTAINER} " ]]; then
    echo "${CONTAINER} container doesn't existed in (${containers[@]})"
    exit 1
fi

ansible-playbook -i host.yml -e deb=${DEB_FILE} -e container=${CONTAINER} playbook/install_deb.yml
