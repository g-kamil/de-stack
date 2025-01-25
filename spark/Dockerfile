FROM python:3.12-alpine AS base

RUN apk update \
    && apk add --no-cache \
    sudo \
    curl \
    vim \
    unzip \
    rsync \
    openjdk17 \
    build-base \
    bash \
    openssh \
    && rm -rf /var/cache/apk/*

ENV SPARK_HOME=${SPARK_HOME:-/opt/spark}
ENV HADOOP_HOME=${HADOOP_HOME:-/opt/hadoop}

RUN mkdir -p ${HADOOP_HOME} ${SPARK_HOME}

RUN adduser -D -h /home/spark spark && \
    chown -R spark:spark $SPARK_HOME $HADOOP_HOME

WORKDIR $SPARK_HOME

ARG SPARK_VERSION=${SPARK_VERSION:-3.5.4}

RUN curl https://dlcdn.apache.org/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop3.tgz -o spark-${SPARK_VERSION}-bin-hadoop3.tgz \
    && tar xvzf spark-${SPARK_VERSION}-bin-hadoop3.tgz --directory /opt/spark --strip-components 1 \
    && rm -rf spark-${SPARK_VERSION}-bin-hadoop3.tgz

FROM base AS pyspark

COPY requirements.txt .

RUN pip3 install -r requirements.txt

ENV PATH="/opt/spark/sbin:/opt/spark/bin:${PATH}"
ENV SPARK_HOME="/opt/spark"
ENV SPARK_MASTER="spark://spark-master:7077"
ENV SPARK_MASTER_HOST="spark-master"
ENV SPARK_MASTER_PORT="7077"
ENV PYSPARK_PYTHON=python3

COPY spark-defaults.conf ${SPARK_HOME}/conf/spark-defaults.conf

RUN chmod u+x /opt/spark/sbin/* \
    && chmod u+x /opt/spark/bin/*

ENV PYTHONPATH=$SPARK_HOME/python/:$PYTHONPATH

COPY entrypoint.sh .

RUN chmod u+x entrypoint.sh

USER spark

ENTRYPOINT [ "./entrypoint.sh" ]
