#!/bin/bash

DOMAINS=${DOMAINS:-}
DNS=${DNS:-8.8.8.8}
FALLBACK=${FALLBACK:-1.1.1.1}
OUT=${OUT:-/etc/systemd/resolved.conf}

set -- \
    "[Resolve]" \
    "DNS=${DNS}" \
    "FallbackDNS=${FALLBACK}"

if [ -n "${DOMAINS}" ]; then
    set -- $@ \
        "Domains=${DOMAINS}"
fi

printf "%s\n" $@ > ${OUT}
