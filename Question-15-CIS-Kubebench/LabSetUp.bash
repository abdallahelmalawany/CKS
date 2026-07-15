#!/bin/bash
# Run on the control-plane node. Deliberately opens up the API server so you
# can practice locking it back down.
set -e

MANIFEST=/etc/kubernetes/manifests/kube-apiserver.yaml
cp "$MANIFEST" "${MANIFEST}.bak"

echo "Weakening API server auth/authz (for practice only)..."
sed -i 's/--anonymous-auth=false/--anonymous-auth=true/' "$MANIFEST" || true
sed -i 's/--authorization-mode=Node,RBAC/--authorization-mode=AlwaysAllow/' "$MANIFEST" || true

echo "Granting system:anonymous cluster-admin (INSECURE, for practice only)..."
kubectl create clusterrolebinding anonymous-admin \
  --clusterrole=cluster-admin --user=system:anonymous \
  --dry-run=client -o yaml | kubectl apply -f - \
  --kubeconfig=/etc/kubernetes/admin.conf

echo "[OK] Done. API server will restart automatically (static pod)."
echo "Run: kube-bench run --targets master --check 1.2.20  to see findings."
echo "Backup of original manifest saved at ${MANIFEST}.bak"
