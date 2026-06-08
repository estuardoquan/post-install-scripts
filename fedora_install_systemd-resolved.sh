#!/bin/bash

RESOLVED_DOMAINS=${RESOLVED_DOMAINS:-}
RESOLVED_DNS=${RESOLVED_DNS:-8.8.8.8}
RESOLVED_FALLBACK=${RESOLVED_FALLBACK:-1.1.1.1}
RESOLVED_OUT=${RESOLVED_OUT:-/etc/systemd/resolved.conf}

set -- \
    "[Resolve]" \
    "DNS=${DNS}" \
    "FallbackDNS=${FALLBACK}"

if [ -n "${DOMAINS}" ]; then
    set -- $@ \
        "Domains=${DOMAINS}"
fi

printf "%s\n" $@ > ${OUT}
