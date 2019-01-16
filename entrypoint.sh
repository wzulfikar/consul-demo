#!/bin/sh

export CONTAINER_IP=$(hostname -i)
echo "consul agent will be available at ${CONTAINER_IP}."
echo "you can access the ui (webapp) at http://${CONTAINER_IP}:8500."
echo ""
echo "run this command to join this consul:"
echo "consul join ${CONTAINER_IP}"
echo ""
echo "initiating consul in 3s.."

sleep 3

consul agent -dev -ui -bind=${CONTAINER_IP} -client=0.0.0.0 -node=docker-container-$(hostname) -config-dir=/consul.d/
