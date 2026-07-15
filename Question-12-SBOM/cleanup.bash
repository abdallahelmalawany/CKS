#!/bin/bash
# Cleanup script for Question 12 - SBOM
set -uo pipefail
echo "Cleaning up Question 12: SBOM..."

kubectl delete deployment alpine -n alpine --ignore-not-found
kubectl delete namespace alpine --ignore-not-found
rm -f /home/candidate/alpine-deployment.yaml /home/candidate/alpine.spdx

echo "[OK] Question 12 cleanup complete"
