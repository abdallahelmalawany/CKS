#!/bin/bash
set -e
kubectl create namespace sec-ns --dry-run=client -o yaml | kubectl apply -f -

cat <<'DEPLOY' > ~/sec-ns_deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: secdep
  namespace: sec-ns
spec:
  replicas: 1
  selector:
    matchLabels:
      app: secdep
  template:
    metadata:
      labels:
        app: secdep
    spec:
      containers:
      - name: secdep
        image: nginx:alpine
DEPLOY

kubectl apply -f ~/sec-ns_deployment.yaml
echo "[OK] Deployed insecure 'secdep' in 'sec-ns' with no securityContext at all."
echo "Manifest saved at ~/sec-ns_deployment.yaml -- edit it now."
