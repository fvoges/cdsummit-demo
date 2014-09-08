#!/bin/bash

SYNC_DIR="$(dirname $0)/sync"

curl -Lo ${SYNC_DIR}/pe-latest.tar.gz "https://pm.puppetlabs.com/cgi-bin/download.cgi?ver=latest&dist=el&arch=x86_64&rel=6"


