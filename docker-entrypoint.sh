#!/bin/sh

export CONTAINER_IP=$(hostname -i)
echo "consul agent will be available at ${CONTAINER_IP}"
echo "run this command from docker host to join this consul:"
echo "consul join ${CONTAINER_IP}"

echo "initiating consul in 5s.."

sleep 5

consul agent -dev -bind=${CONTAINER_IP} -node=docker-container-$(hostname)
