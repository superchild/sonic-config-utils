#!/bin/bash

set -e

usage() {
cat << EOF
Usage: $0 <host_file> <logger_string>
EOF
}

if [ $# -lt 2 ]; then
    usage
    exit 1
fi

HOST_FILE=$1
LOGGER_STRING=$2
shift 2
ansible-playbook -i ${HOST_FILE} -e logger_string="\"${LOGGER_STRING}"\" playbook/logger.yml $@


