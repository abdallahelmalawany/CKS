#!/bin/bash
# Cleanup script for Question 14 - Istio mTLS
set -uo pipefail
echo "Cleaning up Question 14: Istio mTLS..."

kubectl delete peerauthentication default -n app-ns --ignore-not-found
kubectl delete authorizationpolicy allow-only-frontend -n app-ns --ignore-not-found
kubectl delete deployment plain-app -n app-ns --ignore-not-found
kubectl delete namespace app-ns --ignore-not-found
rm -f /tmp/plain-app.yaml peerauth-strict.yaml authz-allow-only-frontend.yaml

echo "[OK] Question 14 cleanup complete"
