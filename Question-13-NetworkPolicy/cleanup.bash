#!/bin/bash
# Cleanup script for Question 13 - Network Policy
set -uo pipefail
echo "Cleaning up Question 13: Network Policy..."

kubectl delete networkpolicy deny-policy -n prod --ignore-not-found
kubectl delete networkpolicy allow-from-prod -n data --ignore-not-found
kubectl delete pod default -n default --ignore-not-found
kubectl delete pod prod svc/prod -n prod --ignore-not-found 2>/dev/null || true
kubectl delete pod data svc/data -n data --ignore-not-found 2>/dev/null || true
kubectl delete namespace prod data --ignore-not-found

echo "[OK] Question 13 cleanup complete"
