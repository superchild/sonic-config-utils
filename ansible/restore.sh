#!/bin/bash

set -e

usage() {
cat << EOF
Usage: $0 <restore_folder>
EOF
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

RESTORE_DIR=$1

ansible-playbook -i host.yml -e restore_dir=${RESTORE_DIR} playbook/restore_config.yml
