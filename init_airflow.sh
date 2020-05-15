#/bin/bash

# pull docker-airflow
docker pull puckel/docker-airflow

# pull docker-dbt
docker pull fishtownanalytics/dbt:0.16.0

# run docker-airflow
docker run --rm -d --network=host -p 8080:8080 puckel/docker-airflow webserver

# update env vars
export AIRFLOW_CONTAINER="$(docker ps -qf ancestor=puckel/docker-airflow)"
