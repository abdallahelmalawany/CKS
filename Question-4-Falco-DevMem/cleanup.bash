#!/bin/bash
# Cleanup script for Question 4 - Falco /dev/mem
set -uo pipefail
echo "Cleaning up Question 4: Falco /dev/mem..."

kubectl delete deployment ollama -n ollama-app --ignore-not-found
kubectl delete namespace ollama-app --ignore-not-found
rm -f /tmp/devmem-rule.yaml /tmp/ollama-deployment.yaml

echo "[OK] Question 4 cleanup complete"
