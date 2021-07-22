#!/bin/bash

set -e

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
TEMPLATE_DIR="$(dirname $(readlink -f "$0"))"
ansible-playbook -i ${HOST_FILE} -e template_dir=${TEMPLATE_DIR}/template playbook/running_cmd.yml
