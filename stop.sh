#!/bin/bash

# Strict mode
set -Eeuxo pipefail

kubectl delete -f deployment/
kubectl delete namespace spark-jupyter