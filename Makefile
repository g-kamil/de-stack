SHELL=/bin/bash
.PHONY: files-clean folders env init start stop docker-clean setup

files-clean: # remove all mounted folders and files
	rm -rf airflow/sources spark/sources airflow/.env spark/.env

folders: files-clean # create necessary folders
	mkdir -p airflow/sources/{config,dags,logs,plugins} spark/sources/{apps,data}

env: # create .env file for airflow
	touch spark/.env
	touch airflow/.env
	echo -e "AIRFLOW_UID=$$(id -u)" > airflow/.env

init: stop # initialize airflow
	docker compose up airflow-init

start: stop # start whole stack
	docker compose up

stop: # stop whole stack
	docker compose down

docker-clean: # stop and remove all containers
	docker compose down --remove-orphans -v

setup: files-clean folders env
	docker compose up airflow-init
