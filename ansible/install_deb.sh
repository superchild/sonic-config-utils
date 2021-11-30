#!/bin/bash

set -e

targets=('snmp'
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
        'database',
        'host')

usage() {
cat << EOF
Usage: $0 <host_file> <deb_file> <target>
EOF
}

if [ $# -lt 3 ]; then
    usage
    exit 1
fi

HOST_FILE=$1
DEB_FILE=$2
TARGET=$3

if [[ ! " ${targets[@]} " =~ " ${TARGET} " ]]; then
    echo "${TARGET} target doesn't existed in (${targets[@]})"
    exit 1
fi

shift 3
ansible-playbook -i ${HOST_FILE} -e deb=${DEB_FILE} -e target=${TARGET} playbook/install_deb.yml $@
