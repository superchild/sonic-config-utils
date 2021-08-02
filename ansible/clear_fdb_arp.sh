#!/bin/bash

usage() {
cat << EOF
Usage: $0 <host_file>
EOF
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

HOST_FILE=$
shift
ansible-playbook -i ${HOST_FILE} playbook/clear_fdb_arp.yml $@