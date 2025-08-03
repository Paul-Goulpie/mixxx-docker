CONTAINER_NAME ?= $(notdir $(CURDIR))
CONTAINER_TAG ?= ${CONTAINER_NAME}:latest

run: build
	docker run \
	    -it \
	    --rm \
	    -v ${PWD}:${PWD} \
	    -e PULSE_SERVER=unix:/tmp/pulse/native \
	    -v /run/user/$$(id -u)/pulse/native:/tmp/pulse/native \
	    -v ~/.config/pulse/cookie:/root/.config/pulse/cookie \
	    --device /dev/snd \
	    --network host \
	    --name ${CONTAINER_NAME} \
	    --privileged \
	    -e DISPLAY=${DISPLAY} \
	    -v /tmp/.X11-unix:/tmp/.X11-unix \
	    ${CONTAINER_TAG} \
	    bash -c "cmake -B build docker/mixxx && \
	             cmake --build build -j$$(nproc) && \
	             bash"

.PHONY:build

build: docker/mixxx/.git
	docker build \
	    --build-arg USER=${USER} \
	    --build-arg UID=$(shell id -u) \
	    --build-arg GID=$(shell id -g) \
	    --build-arg PWD=${PWD} \
	    --build-arg LANG=${LANG} \
	    --tag ${CONTAINER_TAG} \
	    docker


docker/mixxx/.git:
	git submodule init
	git submodule update
