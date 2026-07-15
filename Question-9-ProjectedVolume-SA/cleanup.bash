#!/bin/bash
# Cleanup script for Question 9 - Projected Volume + ServiceAccount
set -uo pipefail
echo "Cleaning up Question 9: Projected Volume + ServiceAccount..."

kubectl delete pod sa-demo-pod -n sa-demo --ignore-not-found
kubectl delete serviceaccount demo-sa -n sa-demo --ignore-not-found
kubectl delete namespace sa-demo --ignore-not-found
rm -f ~/sa-pod.yaml

echo "[OK] Question 9 cleanup complete"
