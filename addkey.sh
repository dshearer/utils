#!/bin/sh

# This tool copies the current user's public SSH key to the specified
# remote host.

usage() {
    echo "addkey.sh USER@HOST" >&2
    exit 1
}

if [ $# -ne 1 ]; then
    usage
fi
USERATHOST=$1

PUBKEY_PATH=${HOME}/.ssh/id_rsa.pub
if [ ! -f "${PUBKEY_PATH}" ]; then
    echo "No key at ${PUBKEY_PATH}" >&2
    exit 1
fi

PUBKEY=`cat "${PUBKEY_PATH}"`
CMD="mkdir -p ~/.ssh && chmod 700 ~/.ssh && echo '${PUBKEY}' >> ~/.ssh/authorized_keys && chmod 600 ~/.ssh/authorized_keys"

ssh "${USERATHOST}" $CMD

