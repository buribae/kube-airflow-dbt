#!/bin/bash
#
# Get logs from the running airflow container
# Assuming logs are located "/usr/local/airflow/logs/"

DAG_NAME=$1
TASK_NAME=$2
LOG_DIR="/usr/local/airflow/logs/$DAG_NAME/$TASK_NAME/*"

show_help() {
    echo "Usage: ./log.sh [dag_name] [task_name] [options]"
    echo "  Options:"
    echo "           -a, --all    Get all logs for a dag"
    echo "           -d, --dag    Set DAG"
    echo "           -t, --task    Set TASK"
    echo "           -h, --help    Show help"
    exit 1
}

task_log() {
    LAST_LOG=$(docker exec "$AIRFLOW_CONTAINER" /bin/bash -cx "cd $LOG_DIR && ls | tail -1")
    docker exec "$AIRFLOW_CONTAINER" /bin/bash -cx "cat $LOG_DIR/$LAST_LOG"
}

dag_logs() {
    # Show all of the lastest logs for a whole DAG recursively
    # Example commands:
    #    ./log.sh dbt_kube_dag -a
    #    ./log.sh -d dbt_kube_dag -a
    for task_dir in $(docker exec "$AIRFLOW_CONTAINER" /bin/bash -c "ls -d /usr/local/airflow/logs/$DAG_NAME/*")
    do
      LOG_DIR="$task_dir/*"
      task_log
    done
    exit 1
}

# No Argument
if [[ $# -eq 0 ]] ; then show_help; fi

# Parse Arguments
while (( "$#" )); do case $1 in
  -a|--all) dag_logs;;
  -d|--dag) DAG_NAME=$2;;
  -t|--task) TASK_NAME=$2;;
  -h|--help) show_help;;
esac; shift; done

# Show All Available logs
echo "Available logs"
docker exec "$AIRFLOW_CONTAINER" /bin/bash -cx "ls /usr/local/airflow/logs/"

# Show lastest log for a task
# Example commands:
#   ./log.sh dbt_kube_dag_simple dbt-debug
#   ./log.sh -d dbt_kube_dag -t dbt-run
task_log