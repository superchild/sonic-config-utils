#!/bin/bash

set -e

usage() {
cat << EOF
Usage: $0 <host_file>
EOF
}

if [ $# -lt 1 ]; then
    usage
    exit 1
fi

HOST_FILE=$1
shift 1
ansible-playbook -i ${HOST_FILE} playbook/copy_scripts.yml $@
