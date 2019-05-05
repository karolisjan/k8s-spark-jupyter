#!/bin/bash

# Strict mode
set -Eeuxo pipefail

unset SPARK_MASTER_PORT

echo "spark.deploy.recoveryDirectory ${SPARK_RECOVERY_DIR}" >> ${SPARK_HOME}/conf/spark-defaults.conf
echo "spark.ui.reverseProxyUrl ${SPARK_PUBLIC_DNS}" >> ${SPARK_HOME}/conf/spark-defaults.conf
echo "SPARK_PUBLIC_DNS=${SPARK_PUBLIC_DNS}" > ${SPARK_HOME}/conf/spark-env.sh

# Run spark-class directly so that when it exits (or crashes), the pod restarts.
${SPARK_HOME}/bin/spark-class org.apache.spark.deploy.master.Master \
    --webui-port 8080
