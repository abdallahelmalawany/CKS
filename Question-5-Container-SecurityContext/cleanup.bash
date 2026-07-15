#!/bin/bash
# Cleanup script for Question 5 - Container Security Context
set -uo pipefail
echo "Cleaning up Question 5: Container Security Context..."

kubectl delete deployment secdep -n sec-ns --ignore-not-found
kubectl delete namespace sec-ns --ignore-not-found
rm -f ~/sec-ns_deployment.yaml

echo "[OK] Question 5 cleanup complete"
