#!/bin/bash

# Strict mode
set -Eeuxo pipefail

kubectl create -f spark-jupyter-namespace.yaml && \
kubectl create -f deployment/
