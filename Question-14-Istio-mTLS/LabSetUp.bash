#!/bin/bash
set -e

if ! command -v istioctl &>/dev/null; then
  echo "istioctl not found. Install with:"
  echo "  curl -L https://istio.io/downloadIstio | sh -"
  echo "  export PATH=\$PWD/istio-*/bin:\$PATH"
  echo "  istioctl install --set profile=minimal -y"
  exit 1
fi

kubectl create namespace app-ns --dry-run=client -o yaml | kubectl apply -f -

cat <<'DEPLOY' > /tmp/plain-app.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: plain-app
  namespace: app-ns
spec:
  replicas: 1
  selector:
    matchLabels:
      app: plain-app
  template:
    metadata:
      labels:
        app: plain-app
    spec:
      containers:
      - name: plain-app
        image: nginx:alpine
DEPLOY
kubectl apply -f /tmp/plain-app.yaml

echo "[OK] Deployed 'plain-app' in 'app-ns' WITHOUT sidecar injection and no mTLS."
echo "Now enable injection + PeerAuthentication per SolutionNotes.bash."
