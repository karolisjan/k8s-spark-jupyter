FROM java:openjdk-8-jdk
LABEL version="latest"

SHELL ["/bin/bash", "-Eeuxo", "pipefail", "-c"]

ENV TINI_VERSION 0.18.0
ENV SPARK_VERSION 2.4.2
ENV HADOOP_VERSION 2.7
ENV CONDA_VERSION 4.6.2

# Tini 
RUN wget --quiet "https://github.com/krallin/tini/releases/download/v${TINI_VERSION}/tini" && \
    mv tini /usr/local/bin/tini && \
    chmod +x /usr/local/bin/tini

ENV SPARK_PACKAGE spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}

# Spark
RUN wget --quiet "http://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" && \
    tar xzf ${SPARK_PACKAGE}.tgz -C /usr/local && \
    mkdir -p /opt && \
    mv /usr/local/${SPARK_PACKAGE} /opt/spark

ENV SPARK_HOME /opt/spark
ENV PYTHONPATH ${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-*.zip
ENV PATH ${SPARK_HOME}/bin:${PATH}

ENV CONDA_HOME /opt/conda

# Conda
RUN wget --quiet "https://repo.anaconda.com/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" \
    /bin/bash Miniconda3-4.1.11-Linux-x86_64.sh -f -b -p ${CONDA_HOME} && \
    rm Miniconda3-${CONDA_HOME}-Linux-x86_64.sh && \
    conda config --system --add channels conda-forge && \
    conda config --system --set auto_update_conda false

RUN conda install --yes \
        'jupyter' \
        'jupyterlab' \
        'nodejs' \
        'pandas' \
        'numpy' \
        'scipy' \
        'sympy' \
        'statsmodels' \
        'scikit-learn' \
        'matplotlib' \
        'seaborn' \
        'plotly' \
        'bokeh' \
        'ipywidgets'

RUN jupyter labextension install @jupyter-widgets/jupyterlab-manager && \
    jupyter labextension install @jupyterlab/plotly-extension && \
    jupyter labextension install jupyterlab_bokeh

ENV {DATA_DIR} /data
RUN mkdir -p ${DATA_DIR}

EXPOSE 8081/tcp

COPY start-spark-worker.sh /usr/local/bin/

CMD ["start-spark-worker.sh"]
