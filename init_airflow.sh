#!/bin/bash
#
# Pull down, launch, setup for docker-airflow

# Pull docker-airflow
docker pull puckel/docker-airflow

# Pull docker-dbt
docker pull fishtownanalytics/dbt:0.16.0

# Run docker-airflow
docker run --rm -d --network=host -p 8080:8080 puckel/docker-airflow webserver

# Set AIRFLOW_CONTAINER with newly running airflow container id
AIRFLOW_CONTAINER="$(docker ps -qf ancestor=puckel/docker-airflow)"
export AIRFLOW_CONTAINER

# Copy airflow dags from local dags folder to the airflow container
docker cp ./dags "$AIRFLOW_CONTAINER":/usr/local/airflow/

# Copy requirements.txt
docker cp ./requirements.txt "$AIRFLOW_CONTAINER":/usr/local/airflow/requirements.txt

# Get k3d kube config
KUBE_CONFIG=$(cat "$(k3d get-kubeconfig --name='k3s-default')")

# Create a kube config file inside the running airflow container with the environment variable KUBE_CONFIG
docker exec "$AIRFLOW_CONTAINER" sh -cx "mkdir -p /usr/local/airflow/.kube/ && echo '$KUBE_CONFIG' > /usr/local/airflow/.kube/config"

# Install additional python packages
docker exec "$AIRFLOW_CONTAINER" sh -cx "pip install -r requirements.txt"

# run airflow list_dags
docker exec "$AIRFLOW_CONTAINER" airflow list_dags