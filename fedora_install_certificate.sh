#!/bin/sh

TARGET=${TARGET:-ca.local/roots.pem}
DEST=${DEST:-/etc/pki/ca-trust/source/anchors}

INSECURE=${INSECURE:-1}
UPDATE=${UPDATE:-1}

set -- \
    -s \
    -o ${DEST}/$(basename ${TARGET}) \
    https://${TARGET}

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

