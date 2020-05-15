#/bin/bash

docker pull puckel/docker-airflow
docker run --rm -d -p 8080:8080 puckel/docker-airflow webserver

# update env vars
export AIRFLOW_CONTAINER="$(docker ps -qf ancestor=puckel/docker-airflow)"
