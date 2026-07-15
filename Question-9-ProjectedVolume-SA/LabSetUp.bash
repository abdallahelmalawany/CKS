#!/bin/bash
set -e
kubectl create namespace sa-demo --dry-run=client -o yaml | kubectl apply -f -
kubectl create serviceaccount demo-sa -n sa-demo --dry-run=client -o yaml | kubectl apply -f -

cat <<'PODYAML' > ~/sa-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: sa-demo-pod
  namespace: sa-demo
spec:
  serviceAccountName: demo-sa
  automountServiceAccountToken: true   # should be false, fix it
  containers:
  - name: app
    image: busybox
    command: ["sleep", "3600"]
PODYAML

kubectl apply -f ~/sa-pod.yaml
echo "[OK] Deployed insecure pod at ~/sa-pod.yaml with default long-lived automounted token."
echo "Fix: disable automount + add a projected volume with serviceAccountToken."
