FROM java:openjdk-8-jdk
LABEL version="latest"

SHELL ["/bin/bash", "-Eeuxo", "pipefail", "-c"]

ENV TINI_VERSION 0.18.0
ENV SPARK_VERSION 2.4.2
ENV HADOOP_VERSION 2.7
ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}

# Tini 
RUN wget --quiet "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini" && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

# Spark
RUN wget --quiet "http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
    tar xzf ${SPARK_PACKAGE}.tgz -C /usr/local && \
    mkdir -p /opt && \
    mv /usr/local/${SPARK_PACKAGE} /opt/spark

ENV SPARK_HOME /opt/spark
ENV PYTHONPATH ${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-*.zip
ENV PATH ${SPARK_HOME}/bin:${PATH}
ENV SPARK_RECOVERY_DIR /data/spark-master

RUN mkdir -p ${SPARK_RECOVERY_DIR}

EXPOSE 8080/tcp 7077/tcp 

COPY spark-defaults.conf ${SPARK_HOME}/conf/spark-defaults.conf
COPY start-spark-master.sh .

CMD ["start-spark-master.sh"]
