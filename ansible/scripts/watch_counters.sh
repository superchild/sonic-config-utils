#!/bin/bash

PORT_CFG=${PORT_CFG:="ports.inc"}
INTERVAL=${INTERVAL:=1}
generate_interfaces() {
    local config=$1
    LLDP_CMD=$(show lldp table | head -n -2 | tail -n +4 | tr -s ' ' | cut -d ' ' -f 1)
    lldp_neighbors=()
    for neighbor in ${LLDP_CMD}
    do
        lldp_neighbors+=("$neighbor")
    done

    printf -v intfs_str '%s,' "${lldp_neighbors[@]}"
    echo "${intfs_str%,}" > ${config}
}

watch_intf_counters() {
    local interval=$1
    local intfs=$2

    sonic-clear counters
    watch -n ${interval} -d "show interface counters -i ${intfs}"
}

if [[ ! -f "${PORT_CFG}" ]]; then
    generate_interfaces ${PORT_CFG}
fi
watch_intf_counters ${INTERVAL} $(cat ${PORT_CFG})