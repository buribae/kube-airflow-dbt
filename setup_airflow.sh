#/bin/bash

# update env vars
export AIRFLOW_CONTAINER="$(docker ps -qf ancestor=puckel/docker-airflow)"

# copy airflow dags
docker cp ./dags $AIRFLOW_CONTAINER:/usr/local/airflow/dags

# copy requirements.txt
docker cp ./requirements.txt $AIRFLOW_CONTAINER:/usr/local/airflow/requirements.txt

# get k3d kube config
KUBE_CONFIG=$(cat $(k3d get-kubeconfig --name='k3s-default'))

# copy .kube/config
docker exec $AIRFLOW_CONTAINER sh -cx "mkdir -p /usr/local/airflow/.kube/ && echo '$KUBE_CONFIG' > /usr/local/airflow/.kube/config"

# install additional python packages
docker exec $AIRFLOW_CONTAINER sh -cx "pip install -r requirements.txt"

# run airflow with local executor
#docker exec $AIRFLOW_CONTAINER sh -cx "sed -i 's/executor = SequentialExecutor/executor = LocalExecutor/' /usr/local/airflow/airflow.cfg"

# run airflow list_dags
docker exec $AIRFLOW_CONTAINER airflow list_dags
