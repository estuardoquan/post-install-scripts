#!/bin/sh

CERT=${CERT:-ca.local/roots.pem}
OUT=${OUT:-/etc/pki/ca-trust/source/anchors/roots.pem}

INSECURE=${INSECURE:-0}
UPDATE=${UPDATE:-0}

set -- \
    -s \
    -o ${OUT}\
    https://${CERT}

if [ ${INSECURE} = 1 ]; then
    set -- $@ \
        -k
fi


curl $@

if [ $? != 0 ]; then
    printf "%s\n" ERROR
    exit 1
fi

if [ ${UPDATE} = 1 ]; then
    update-ca-trust
fi

