#!/bin/bash

usage() {
cat << EOF
Usage: $0 <host_file>
EOF
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

HOST_FILE=$1
ansible-playbook -i ${HOST_FILE} playbook/reboot.yml