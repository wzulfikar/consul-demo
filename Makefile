CURRENT_DIR:=$(shell pwd)
DOCKERHOST:=$(shell ip -4 addr show docker0 | grep -Po 'inet \K[\d.]+')

# display ip of dockerhost (bridged network at 'docker0')
ip-dockerhost:
	@echo 'docker host ip: ${DOCKERHOST}'

# run consul agent
serve:
	@echo 'running consul agent. ui is accessible at http://${DOCKERHOST}:8500/ui'
	consul agent -dev -ui -config-dir=consul.d/ -log-file=logs/ -bind=${DOCKERHOST}

serve-docker:
	@echo 'running consul agent from within docker..'
	docker run -it --rm -v ${CURRENT_DIR}/docker-entrypoint.sh:/entrypoint.sh --entrypoint /entrypoint.sh consul

# simulate healthy 'web1' endpoint
web1:
	httpdump 8111

# simulate healthy 'web1' endpoint 
web2:
	httpdump 8112
