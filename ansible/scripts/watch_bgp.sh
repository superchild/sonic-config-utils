#!/bin/bash

INTERVAL=${INTERVAL:-1}
watch -n ${INTERVAL} -d "show ip bgp summary"
