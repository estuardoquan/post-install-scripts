#!/bin/sh

CA_TARGET=${CA_TARGET:-https://ca.local/roots.pem}
CA_DEST=${CA_DEST:-/etc/pki/ca-trust/source/anchors}

CA_INSECURE=${CA_INSECURE:-1}
CA_UPDATE=${CA_UPDATE:-1}

set -- \
    -s \
    -o ${CA_DEST}/$(basename ${CA_TARGET}) \
    ${CA_TARGET}

if [ ${CA_INSECURE} = 1 ]; then
    set -- $@ \
        -k
fi


echo $@

if [ $? != 0 ]; then
    printf "%s\n" ERROR
    exit 1
fi

if [ ${CA_UPDATE} = 1 ]; then
    update-ca-trust
fi

