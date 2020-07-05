THIS_FILE := $(lastword $(MAKEFILE_LIST))
SHELL := /bin/bash

apply:
	./env/terraform.sh run $(env) $(module)

apply_setup:
	$(MAKE) -f $(THIS_FILE) apply env=$(env) module=setup

apply_infra:
	$(MAKE) -f $(THIS_FILE) apply env=$(env) module=infra

apply_apps:
	$(MAKE) -f $(THIS_FILE) apply env=$(env) module=apps