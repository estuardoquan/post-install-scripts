#!/bin/sh

FILE=${FILE:-https://raw.githubusercontent.com/estuardoquan/.dotfiles/refs/heads/main/bin/ddns.sh}
OUT=${OUT:-/usr/local/bin/nsupdate-hostname}

curl -s -o ${OUT} ${FILE}

if [ -f ${OUT} ]; then
    chmod +x ${OUT}
fi
