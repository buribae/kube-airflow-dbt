#/bin/bash

LOG_DIR="/usr/local/airflow/logs/dbt_kube_dag/dbt-debug/*"
LAST_LOG=$(docker exec $AIRFLOW_CONTAINER /bin/bash -cx "cd $LOG_DIR && ls | tail -1")

docker exec $AIRFLOW_CONTAINER /bin/bash -cx "cat $LOG_DIR/$LAST_LOG"