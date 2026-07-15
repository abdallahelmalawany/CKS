#!/bin/bash
# Cleanup script for Question 6 - Ingress TLS + Redirect
set -uo pipefail
echo "Cleaning up Question 6: Ingress TLS + Redirect..."

kubectl delete ingress secure-ingress -n app-ns --ignore-not-found
kubectl delete secret my-tls -n app-ns --ignore-not-found

echo "[OK] Question 6 cleanup complete"
