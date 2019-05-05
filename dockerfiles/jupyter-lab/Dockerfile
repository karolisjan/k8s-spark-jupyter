FROM java:openjdk-8-jdk
LABEL version="latest"

SHELL ["/bin/bash", "-Eeuxo", "pipefail", "-c"]

ENV TINI_VERSION 0.18.0
ENV SPARK_VERSION 2.4.2
ENV HADOOP_VERSION 2.7
ENV CONDA_VERSION latest

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
RUN wget --quiet "https://repo.continuum.io/miniconda/Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh" && \
    /bin/bash Miniconda3-${CONDA_VERSION}-Linux-x86_64.sh -f -b -p ${CONDA_HOME} 

ENV PATH ${CONDA_HOME}/bin:${PATH}

RUN conda config --system --add channels conda-forge && \
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

# Setup Jupyter config
ENV JUPYTER_CONFIG_DIR /opt/jupyter/config
RUN mkdir -p ${JUPYTER_CONFIG_DIR}
COPY jupyter_notebook_config.py ${JUPYTER_CONFIG_DIR}
RUN mkdir -p /notebooks

# Apache Toree kernel for Spark and notebook interaction with Spark 2.0
RUN pip install toree && \
    jupyter toree install \
        --ToreeInstall.prefix=${CONDA_HOME} \
        --ToreeInstall.toree_opts=--nosparkcontext

EXPOSE 8888

COPY start-jupyter-lab.sh /usr/local/bin/

CMD ["start-jupyter-lab.sh"]
