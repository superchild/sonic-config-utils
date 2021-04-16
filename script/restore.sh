#!/bin/bash

set -e

usage() {
cat << EOF
Usage: $0 <devices_ip_config> <restore_folder>
EOF
}

if [ $# -ne 2 ]; then
    usage
    exit 1
fi

CONFIG=$1
FOLDER=$2
PASSWORD="YourPaSsWoRd"
declare -A devices

read_config() {
    local config=$1
    while read line || [ -n "$line" ]; do
        if [[ $line =~ ^(.*)"="(.*)$ ]]; then
            devices[${BASH_REMATCH[1]}]="${BASH_REMATCH[2]}"
        fi
    done < ${config}
}

restore () {
    device=$1
    ip=$2

    echo "Retore ${device} config_db.json and frr.conf..."
    cat ./${FOLDER}/${device}/config_db.json | sshpass -p ${PASSWORD} ssh -q -o StrictHostKeyChecking=no admin@${ip} "sudo sh -c 'cat > /etc/sonic/config_db.json'"
    cat ./${FOLDER}/${device}/frr.conf | sshpass -p ${PASSWORD} ssh -q -o StrictHostKeyChecking=no admin@${ip} "sudo sh -c 'cat > /etc/sonic/frr/frr.conf'"
}

read_config ${CONFIG}
echo "Start restore process..."

for device in "${!devices[@]}";
do
    restore $device ${devices[$device]}
done

echo "Finished restore process! Remember to reboot devices!"

