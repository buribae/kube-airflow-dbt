# kube-airflow

### Dependencies
- [rancher/k3d](https://github.com/rancher/k3d)
- [docker](https://docs.docker.com/get-docker/)

```sh

# pull down docker-airflow image
./init_airflow.sh

# setup airflow - copy dags, kube config, install python packages
source setup_airflow.sh

# run dbt_kube_dag in dags folder
# ./run.sh [dag_name] [task_name]
./run.sh dbt_kube_dag dbt-debug

# see 1.log using log.sh
./log.sh 1

# clear airflow dag
# sqlite doesn't support local executor
./clean.sh dbt_kube_dag

```