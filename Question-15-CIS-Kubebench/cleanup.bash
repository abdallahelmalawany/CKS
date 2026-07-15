#!/bin/bash
# Cleanup script for Question 15 - CIS Benchmark / kube-bench
set -uo pipefail
echo "Cleaning up Question 15: CIS Benchmark..."

MANIFEST=/etc/kubernetes/manifests/kube-apiserver.yaml
if [ -f "${MANIFEST}.bak" ]; then
  cp "${MANIFEST}.bak" "$MANIFEST"
  rm -f "${MANIFEST}.bak"
  echo "Restored original kube-apiserver.yaml"
fi

kubectl --kubeconfig=/etc/kubernetes/admin.conf delete clusterrolebinding anonymous-admin --ignore-not-found

echo "[OK] Question 15 cleanup complete"
