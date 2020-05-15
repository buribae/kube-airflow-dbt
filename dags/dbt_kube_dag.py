from airflow import DAG
from datetime import datetime, timedelta
from airflow.contrib.operators.kubernetes_pod_operator import KubernetesPodOperator
import os

default_args = {
    "owner": "airflow",
    "depends_on_past": False,
    "start_date": datetime(2001, 1, 1),
    "email": ["airflow@example.com"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 0,
}

with DAG("dbt_kube_dag", default_args=default_args, schedule_interval="@once") as dag:
    dbt_debug = KubernetesPodOperator(
        namespace="default",
        image="fishtownanalytics/dbt:0.16.0",
        cmds=["/bin/bash", "-cx", "dbt debug"],
        name="dbt-debug",
        task_id="dbt-debug",
        config_file="/usr/local/airflow/.kube/config",
        env_vars={"ENV_EXAMPLE": "example"},
        in_cluster=False,
        is_delete_operator_pod=True,
        get_logs=True,
    )
    dbt_debug
