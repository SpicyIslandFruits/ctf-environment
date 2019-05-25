help:
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

.DEFAULT_GOAL := help

# Build the container
build: ## Use 'make build' to build the container
	docker-compose build

run: ## Use 'make run' to run container
	xhost +local: \
	&& docker run \
		-it \
		--name ctf \
		--cap-add=SYS_PTRACE \
		--security-opt seccomp=unconfined \
		-e DISPLAY=$$DISPLAY \
		-v /tmp/.X11-unix/:/tmp/.X11-unix/ \
		ctf_environment

start: ## Use 'make start' to start container
	xhost +local: \
	&& docker start -i ctf
