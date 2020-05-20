# kube-airflow-dbt

### Requirements
- [rancher/k3d](https://github.com/rancher/k3d)
- [docker](https://docs.docker.com/get-docker/)
- dbt
### How to run dags with puckel/docker-airflow

```sh
# Initialize docker-airflow, docker-dbt
# Copy dags, kube config into running container
# Install python packages
source init_airflow.sh

# To run airflow task in dag
# ./run.sh [dag_name] [task_name]
./run.sh dbt_kube_dag dbt_debug

# Look up the last log with log.sh
./log.sh
```
