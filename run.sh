#/bin/bash

# Expected Input:
# $1: dag_name
# $2: task_name

# clean up dag run
docker exec $AIRFLOW_CONTAINER airflow clear -c $1

# run airflow dag
docker exec $AIRFLOW_CONTAINER airflow run $1 $2 2020-01-01

