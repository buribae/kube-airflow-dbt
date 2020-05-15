#/bin/bash

# expected usage:
# ./log.sh 1
# ./log.sh 2

docker exec $AIRFLOW_CONTAINER cat logs/dbt_kube_dag/dbt-debug/2020-01-01T00\:00\:00+00\:00/$1.log
