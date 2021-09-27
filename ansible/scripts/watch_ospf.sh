#!/bin/bash

OSPF_VRF=$(vtysh -c 'show running' | grep 'router ospf vrf' | awk '{ print $3 " " $4 }')
INTERVAL=${INTERVAL:-1}

if [[ -z "${OSPF_VRF}" ]]; then
    OSPF_CMD="vtysh -c 'show ip ospf neighbor'"
else
    OSPF_CMD="vtysh -c 'show ip ospf ${OSPF_VRF} neighbor'"
fi

watch -n ${INTERVAL} -d ${OSPF_CMD}
