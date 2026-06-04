#!/bin/sh

HOSTNAME_NSUPDATE_FILE=${HOSTNAME_NSUPDATE_FILE:-https://github.com/estuardoquan/usr-local-bin/raw/refs/heads/main/hostname-nsupdate.sh}
HOSTNAME_NSUPDATE_OUT=${HOSTNAME_NSUPDATE_OUT:-/usr/local/bin/hostname-nsupdate}

curl -s -o ${HOSTNAME_NSUPDATE_OUT} ${HOSTNAME_NSUPDATE_FILE}

if [ -f ${HOSTNAME_NSUPDATE_OUT} ]; then
    chmod +x ${HOSTNAME_NSUPDATE_OUT}
fi

HOSTNAME_CHANGE_FILE=${HOSTNAME_CHANGE_FILE:-https://github.com/estuardoquan/usr-local-bin/raw/refs/heads/main/hostname-change.sh}
HOSTNAME_CHANGE_OUT=${HOSTNAME_CHANGE_OUT:-/usr/local/bin/hostname-change}

curl -s -o ${HOSTNAME_CHANGE_OUT} ${HOSTNAME_CHANGE_FILE}

if [ -f ${HOSTNAME_CHANGE_OUT} ]; then
    chmod +x ${HOSTNAME_CHANGE_OUT}
fi

HOSTNAME_WATCH_DIR=${HOSTNAME_WATCH_DIR:-/etc/systemd/system}
HOSTNAME_WATCH_PATH=${HOSTNAME_WATCH_PATH:-$HOSTNAME_WATCH_DIR/hostname-watch.path}
HOSTNAME_WATCH_SERVICE=${HOSTNAME_WATCH_SERVICE:-$HOSTNAME_WATCH_DIR/hostname-watch.service}

cat << EOF > ${HOSTNAME_WATCH_PATH}
[Unit]
Description='Watch /etc/hostname for changes'

[Path]
PathModified=/etc/hostname
Unit=hostname-watch.service

[Install]
WantedBy=multi-user.target
EOF

cat << EOF > ${HOSTNAME_WATCH_SERVICE}
[Unit]
Description='Log hostname changes'

[Service]
Type=oneshot
ExecStart=/usr/local/bin/hostname-change
EOF
