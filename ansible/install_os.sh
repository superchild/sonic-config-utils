#!/bin/bash

set -e

usage() {
cat << EOF
Usage: $0 <image_url>
EOF
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi
IMAGE_URL=$1
ansible-playbook -i host.yml -e image_url=${IMAGE_URL} playbook/install_os.yml
