#!/bin/sh

DEST=${DEST:-/usr/local/bin}
TARGET=${TARGET:-
"https://raw.githubusercontent.com/estuardoquan/usr-local-bin/refs/heads/main/hostname-change.sh
https://raw.githubusercontent.com/estuardoquan/usr-local-bin/refs/heads/main/hostname-nsupdate.sh"
}

for f in ${TARGET}; do
    n=$(basename $f)
    curl -s -o ${DEST}/$n $f

    chmod +x $n 
done
unset f n

WATCH_DIR=${WATCH_DIR:-/etc/systemd/system}
WATCH_PATH=${WATCH_PATH:-${WATCH_DIR}/hostname-watch.path}
WATCH_SERVICE=${WATCH_SERVICE:-${WATCH_DIR}/hostname-watch.service}
WATCH_EXEC=${WATCH_EXEC:-/usr/local/bin/hostname-change.sh}

set -- \
    "[Unit]" \
    "Description='Log hostname changes'" \
    "[Service]" \
    "Type=oneshot" \
    "ExecStart=${WATCH_EXEC}"

printf "%s\n" $@ > ${WATCH_SERVICE}

set -- \
    "[Unit]" \
    "Description='Watch /etc/hostname for changes'" \
    "[Path]" \
    "PathModified=/etc/hostname" \
    "Unit=$(basename ${WATCH_SERVICE})" \
    "[Install]" \
    "WantedBy=multi-user.target"


printf "%s\n" $@ > ${WATCH_PATH}

