#!/bin/bash

set -e

usage() {
cat << EOF
Usage: $0 <host_file> <image_url>
EOF
}

if [ $# -lt 2 ]; then
    usage
    exit 1
fi

HOST_FILE=$1
IMAGE_URL=$2
shift
ansible-playbook -i ${HOST_FILE} -e image_url=${IMAGE_URL} playbook/install_os.yml $@
