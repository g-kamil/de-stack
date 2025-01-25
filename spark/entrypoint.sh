#!/bin/bash
set -e

SPARK_WORKLOAD=$1

echo "SPARK_WORKLOAD: $SPARK_WORKLOAD"

case "$SPARK_WORKLOAD" in
  "master")
    start-master.sh
    ;;
  "worker")
    start-worker.sh spark://spark-master:7077
    ;;
  "history")
    start-history-server.sh
    ;;
  *)
    echo "Error: Unknown workload '$SPARK_WORKLOAD'"
    exit 1
    ;;
esac
