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
Usage: $0 <host_file> <deb_file> <container>
EOF
}

if [ $# -ne 3 ]; then
    usage
    exit 1
fi

HOST_FILE=$1
DEB_FILE=$2
CONTAINER=$3

if [[ ! " ${containers[@]} " =~ " ${CONTAINER} " ]]; then
    echo "${CONTAINER} container doesn't existed in (${containers[@]})"
    exit 1
fi

ansible-playbook -i ${HOST_FILE} -e deb=${DEB_FILE} -e container=${CONTAINER} playbook/install_deb.yml
