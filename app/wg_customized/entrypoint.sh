#!/bin/sh
set -e

# Determine IP address based on available environment variables
if [ -n "$WG_SERVER_ID" ]; then
  # Calculate IP from Server ID (Server logic)
  SED_IP="10.8.$((WG_SERVER_ID >> 8)).$((WG_SERVER_ID & 255))"
elif [ -n "$WG_IP" ]; then
  # Use provided IP directly (Client logic)
  SED_IP="$WG_IP"
else
  echo "❌ Error: Neither WG_SERVER_ID nor WG_IP is set."
  exit 1
fi

echo "IP: $SED_IP"

if [ -f /config/wg_confs/wg0.conf ]; then
  echo 'ℹ️  regenerating wg0.conf from existing...'
  cp /_tmp/cfg /tmp/cfg

  # extract existing private key
  SED_KEY=$(awk '/^PrivateKey/ {print $3}' /config/wg_confs/wg0.conf | tr -d ' \r\n')
  # Append all [Peer] sections from old config
  awk '/^\[Peer\]/ {print_flag=1} print_flag {print}' /config/wg_confs/wg0.conf >> /tmp/cfg

  mv /tmp/cfg /config/wg_confs/wg0.conf

else
  echo '✅ creating new wg0.conf.'

  SED_KEY=$(wg genkey)
  mkdir -p /config/wg_confs
  cp /_tmp/cfg /config/wg_confs/wg0.conf

fi

# Apply Key and IP to the config file
sed -i -e "s|{{KEY}}|${SED_KEY}|g" -e "s|{{IP}}|${SED_IP}|g" /config/wg_confs/wg0.conf

exec /init
