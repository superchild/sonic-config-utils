# Backup and Restore SONiC/FRR config

## Config File
The template config file is `env.conf`, backup/restore scripts needs to specify the target devices name and ip as the following format
```
spine-1=192.168.8.121
spine-2=192.168.8.122
leaf-1=192.168.8.123
leaf-2=192.168.8.124
ext-leaf-1=192.168.8.125
ext-leaf-2=192.168.8.126
```

## Folder Structure
The devices' config file needs to be consistent in the following folder strcture, and the folder name should be the same as config file
```
.
└── 20210401_165045
    ├── ext-leaf-1
    │   ├── config_db.json
    │   └── frr.conf
    ├── ext-leaf-2
    │   ├── config_db.json
    │   └── frr.conf
    ├── leaf-1
    │   ├── config_db.json
    │   └── frr.conf
    ├── leaf-2
    │   ├── config_db.json
    │   └── frr.conf
    ├── spine-1
    │   ├── config_db.json
    │   └── frr.conf
    └── spine-2
        ├── config_db.json
        └── frr.conf
```

## Backup
This script backup SONiC `config_db.json` and `frr.conf` to local folder under `./backup/<date +%Y%m%d_%H%M%S>`, 

```
Usage: ./backup.sh env.conf
```

## Restore
This script restore SONiC `config_db.json` and `frr.conf` from local specified folder to devices

```
Usage: ./restore.sh env.conf ./backup/20210401_165045
```