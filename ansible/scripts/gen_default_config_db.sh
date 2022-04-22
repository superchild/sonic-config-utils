#!/bin/bash

$(show platform summary | sed 's/: /=/g' | sed 's/ /_/g' | sed 's/^/export /g');
sonic-cfggen -H -k $HwSKU -p /usr/share/sonic/device/$Platform/platform.json -t /tmp/factory.j2 > /tmp/config_db_tpl.json
k=`redis-cli --raw -n 4 KEYS 'MGMT_INTERFACE|eth0*'`;
ipv4=`echo $k  | sed -e 's/MGMT_INTERFACE|eth0|//g' | sed -e 's/\//\\\\\//g'`;
gwaddr=`redis-cli --raw -n 4 HGET "$k" gwaddr`;
cat /tmp/config_db_tpl.json| sed -e "s/192.168.99.99\/24/$ipv4/g" | sed -e "s/192.168.99.254/$gwaddr/g" > /tmp/config_db.json
