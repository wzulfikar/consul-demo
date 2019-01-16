CURRENT_DIR:=$(shell pwd)
DOCKERHOST:=$(shell ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')

serve:
	@echo 'running consul agent from within docker..'
	docker run -it --rm \
	--add-host=dockerhost:${DOCKERHOST} \
	-v ${CURRENT_DIR}/docker/:/data/ \
	-v ${CURRENT_DIR}/consul.d/:/consul.d/ \
	--entrypoint /data/entrypoint.sh \
	consul

# join consul cluster.
# usage: make join container=<container id> ip=<ip of cluster member>
# example: make join container=eb98ca0b38a7 ip=172.17.0.2
join:
	docker exec -it ${container} consul join ${ip}

# show consul members.
# usage: make show-members container=<container id>
# example: make show-members container=eb98ca0b38a7
show-members:
	docker exec -it ${container} consul members

# simulate a healthy http endpoint at dockerhost
dockerhost-hello:
	${CURRENT_DIR}/docker/httphello 8112
