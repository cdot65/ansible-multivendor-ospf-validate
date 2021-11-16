SHELL := /usr/bin/env bash
.DEFAULT_GOAL := help
.PHONY: help ansible container shell

DOCKER_IMG = registry.gitlab.com/cremsburg/juniper-automation-container
DOCKER_TAG = 0.1.2

help:
	@echo ''
	@echo 'Makefile will help us build with the following commands'
	@echo '		make container				builds the container'
	@echo '		make shell				runs the container and gives you shell access'
	@echo '		make ansible				runs the Ansible playbook'


ansible:
	docker run -it \
	--rm \
	-v $(PWD)/ansible/:/home/ansible \
	-w /home/ansible/ \
	$(DOCKER_IMG):$(DOCKER_TAG) ansible-playbook ppb.retrieve.ospf.info.yaml

container:
	docker build -t $(DOCKER_IMG):$(DOCKER_TAG) docker/

shell:
	docker run -it \
	--rm \
	-v $(PWD)/ansible/:/home/ansible \
	-w /home/ansible/ \
	$(DOCKER_IMG):$(DOCKER_TAG) /bin/bash
