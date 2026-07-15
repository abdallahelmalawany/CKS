#!/bin/bash
# Cleanup script for Question 16 - Seccomp Profile
set -uo pipefail
echo "Cleaning up Question 16: Seccomp Profile..."

kubectl delete pod seccomp-demo -n default --ignore-not-found
rm -f /var/lib/kubelet/seccomp/profiles/restrictive.json
rm -f ~/seccomp-pod.yaml

echo "[OK] Question 16 cleanup complete"
