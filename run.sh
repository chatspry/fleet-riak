#!/bin/bash

# Fail hard and fast
set -eo pipefail

export ETCD_PORT=${ETCD_PORT:-4001}
export HOST_IP=${HOST_IP:-172.17.42.1}
export ETCD="$HOST_IP:$ETCD_PORT"

echo "[riak] booting container. etcd: $ETCD"

# Loop until confd has updated the riak config
until confd -onetime -node $ETCD -config-file "/etc/confd/conf.d/riak.toml"; do
  echo "[riak] waiting for confd to refresh riak.conf"
  sleep 5
done

# Start riak
echo "[riak] starting riak service..."
riak start

# Run confd in the background to watch the upstream servers
echo "[riak] confd is listening for changes on etcd..."
confd -watch -debug -interval 10 -node $ETCD -config-file "/etc/confd/conf.d/riak.toml"
