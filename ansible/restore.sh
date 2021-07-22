#!/bin/bash

set -e

usage() {
cat << EOF
Usage: $0 <host_file> <restore_folder>
EOF
}

if [ $# -ne 2 ]; then
    usage
    exit 1
fi

HOST_FILE=$1
RESTORE_DIR="$(readlink -f "$2")"
ansible-playbook -i ${HOST_FILE} -e restore_dir=${RESTORE_DIR} playbook/restore_config.yml
