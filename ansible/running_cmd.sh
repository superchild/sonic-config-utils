#!/bin/bash

set -e

TEMPLATE_DIR="$(dirname $(readlink -f "$0"))"
ansible-playbook -i host.yml -e template_dir=${TEMPLATE_DIR}/template playbook/running_cmd.yml
