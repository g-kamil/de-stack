
# Services

Current services:

	- airflow/
		- airflow-triggerer
		- airflow-scheduler
		- airflow-worker
		- airflow-webserver (web @ localhost:8080)
		- postgres
		- redis
	- spark/
		- spark-master (:7077) (web @ localhost:8081)
		- spark-worker


# How to

Makefile is using `SHELL=/bin/bash` - adjust it if needed

`make setup` to do all initial steps

`make start` after everything has been set up correctly
