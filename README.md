# kube-airflow

### Requirements
- [rancher/k3d](https://github.com/rancher/k3d)
- [docker](https://docs.docker.com/get-docker/)

### How to run dags with puckel/docker-airflow

```sh
# 1. pull down docker-airflow image
./init_airflow.sh

# 2. setup airflow - copy dags, kube config, install python packages
source setup_airflow.sh

# 3. run dbt_kube_dag in dags folder
# ./run.sh [dag_name] [task_name]
./run.sh dbt_kube_dag dbt-debug

# 4. look up the last log with log.sh
./log.sh
```