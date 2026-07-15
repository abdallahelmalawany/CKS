#!/bin/bash
set -e
kubectl create namespace alpine --dry-run=client -o yaml | kubectl apply -f -

cat <<'DEPLOY' > /home/candidate/alpine-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: alpine
  namespace: alpine
spec:
  replicas: 1
  selector:
    matchLabels:
      app: alpine
  template:
    metadata:
      labels:
        app: alpine
    spec:
      containers:
      - name: c1
        image: alpine:3.20.0
        command: ["sleep", "3600"]
      - name: c2
        image: alpine:3.19.6
        command: ["sleep", "3600"]
      - name: c3
        image: alpine:3.16.1
        command: ["sleep", "3600"]
DEPLOY

kubectl apply -f /home/candidate/alpine-deployment.yaml
echo "[OK] Deployed 3-container 'alpine' Deployment in ns 'alpine'."
echo "Manifest at /home/candidate/alpine-deployment.yaml"
echo "Install bom if missing:"
echo "  curl -LO https://github.com/kubernetes-sigs/bom/releases/download/v0.7.1/bom-amd64-linux"
echo "  chmod +x bom-amd64-linux && sudo mv bom-amd64-linux /usr/local/bin/bom"
