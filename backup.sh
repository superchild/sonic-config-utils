#!/bin/bash

set -e

usage() {
cat << EOF
Usage: $0 <devices_ip_config>
EOF
}

if [ $# -ne 1 ]; then
    usage
    exit 1
fi

CONFIG=$1
PASSWORD="YourPaSsWoRd"
FOLDER=./backup/$(date +%Y%m%d_%H%M%S)
declare -A devices

read_config() {
    local config=$1
    while read line || [ -n "$line" ]; do
        if [[ $line =~ ^(.*)"="(.*)$ ]]; then
            devices[${BASH_REMATCH[1]}]="${BASH_REMATCH[2]}"
        fi
    done < ${config}
}

backup () {
    device=$1
    ip=$2

    echo "Create ${device} folder..."
    mkdir ${device}

    echo "    Backup config_db.json and frr.conf..."
    sshpass -p ${PASSWORD} ssh -q -o StrictHostKeyChecking=no admin@${ip} "sudo cat /etc/sonic/config_db.json" > ./${device}/config_db.json
    sshpass -p ${PASSWORD} ssh -q -o StrictHostKeyChecking=no admin@${ip} "sudo cat /etc/sonic/frr/frr.conf" > ./${device}/frr.conf
}

read_config ${CONFIG}

echo "Start backup process..."
echo "Create backup folder ${FOLDER}..."
mkdir ${FOLDER}
pushd ${FOLDER}
for device in "${!devices[@]}";
do
    backup $device ${devices[$device]}
done
popd

echo "Finished backup process!"


