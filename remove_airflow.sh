docker stop $AIRFLOW_CONTAINER
docker rm $AIRFLOW_CONTAINER

docker container prune -f
