#!/bin/sh

apk add socat

__export_env_vars() {
	export CONTAINER_IP=$(hostname -i)
	export NODE_NAME=docker-container--$(hostname)
}

__export_env_vars

echo "running 'httphello' to simulate a running web service at http://${CONTAINER_IP}.."
/data/httphello &

echo "service registration is scheduled in 10s.."
sleep 10 && /data/registerservice &

sleep 2

echo "forwarding dns inbound UDP:53 to 8600.."
/data/dnsforward &
sleep 2

echo "consul agent will be available at ${CONTAINER_IP}."
echo "you can access consul ui at http://${CONTAINER_IP}:8500."
echo "node name: ${NODE_NAME}"
echo "container id: $(hostname)"
echo ""
echo "run this command to join this consul:"
echo "consul join ${CONTAINER_IP}"
echo ""
echo "initiating consul in 3s.."

sleep 3

consul agent -dev -ui -bind=${CONTAINER_IP} -client=0.0.0.0 -node=${NODE_NAME} -config-dir=/consul.d/
