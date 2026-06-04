#!/bin/sh

sudo dnf config-manager addrepo --from-repofile=https://rpm.releases.hashicorp.com/fedora/hashicorp.repo

dnf check-update
dnf update -y

dnf install -y \
    terraform \
    packer
