CURRENT_DIR:=$(shell pwd)
DOCKERHOST:=$(shell ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')

serve:
	@echo 'running consul agent from within docker..'
	docker run -it --rm \
	--add-host=dockerhost:${DOCKERHOST} \
	-v ${CURRENT_DIR}/entrypoint.sh:/entrypoint.sh \
	-v ${CURRENT_DIR}/consul.d/:/consul.d/ \
	--entrypoint /entrypoint.sh \
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

# simulate healthy 'web1' endpoint
web1:
	httpdump 8111

# simulate healthy 'web1' endpoint 
web2:
	httpdump 8112
