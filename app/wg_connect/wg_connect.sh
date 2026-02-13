#!/bin/bash
set -e
usage() {
    echo "Usage: $0 <REMOTE_IP> [REMOTE_USER] [REMOTE_CONTAINER] [LOCAL_CONTAINER]"
    echo "Example: $0 1.2.3.4 root wireguard_server wireguard_client"
    exit 1
}

if [ -z "$1" ]; then usage; fi

REMOTE_IP=$1
REMOTE_USER=${2:-root}
REMOTE_SERVER_NAME=${3:-wireguard_server}
LOCAL_CLIENT_NAME=${4:-wireguard_client}
WG_NET="10.8.0.0/16"

echo "⏳ establishing wg tunnel to [${REMOTE_IP}] ..."

LOCAL_PUBKEY=$(docker exec "${LOCAL_CLIENT_NAME}" wg show wg0 public-key)
REMOTE_PUBKEY=$(ssh -o ConnectTimeout=5 "${REMOTE_USER}@${REMOTE_IP}" \
    "docker exec ${REMOTE_SERVER_NAME} wg show wg0 public-key")

docker exec "${LOCAL_CLIENT_NAME}" wg set wg0 \
    peer "${REMOTE_PUBKEY}" \
    endpoint "${REMOTE_IP}:51820" \
    allowed-ips "${WG_NET}" \
    persistent-keepalive 25
docker exec "${LOCAL_CLIENT_NAME}" bash -c "wg showconf wg0 > /config/wg_confs/wg0.conf"

ssh "${REMOTE_USER}@${REMOTE_IP}" \
    "docker exec ${REMOTE_SERVER_NAME} wg set wg0 peer ${LOCAL_PUBKEY} allowed-ips ${WG_NET}"
ssh "${REMOTE_USER}@${REMOTE_IP}" \
    "docker exec ${REMOTE_SERVER_NAME} bash -c 'wg showconf wg0 > /config/wg_confs/wg0.conf'"

echo "✅ established wg tunnel to [${REMOTE_IP}] ..."
