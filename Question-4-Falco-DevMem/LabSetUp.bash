#!/bin/bash
# Simulates the scenario: a Falco rule watching /dev/mem, and a Deployment
# whose pod actually reads from /dev/mem so Falco fires an alert.
set -e

echo "Creating the ollama-app namespace..."
kubectl create namespace ollama-app --dry-run=client -o yaml | kubectl apply -f -

cat <<'RULE' > /tmp/devmem-rule.yaml
- rule: devmem access practice
  desc: Detect access to /dev/mem from containers
  condition: open_read and container and fd.name = /dev/mem
  output: "/dev/mem access by container=%container.id pod=%k8s.pod.name ns=%k8s.ns.name"
  priority: WARNING
RULE
echo "Custom Falco rule written to /tmp/devmem-rule.yaml -- merge into your falco_rules.local.yaml"

cat <<'DEPLOY' > /tmp/ollama-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: ollama
  namespace: ollama-app
spec:
  replicas: 1
  selector:
    matchLabels:
      app: ollama
  template:
    metadata:
      labels:
        app: ollama
    spec:
      containers:
      - name: ollama
        image: busybox
        command: ["sh", "-c", "while true; do head -c 16 /dev/mem 2>/dev/null; sleep 5; done"]
        securityContext:
          privileged: true
DEPLOY
kubectl apply -f /tmp/ollama-deployment.yaml

echo "[OK] Deployed 'ollama' in namespace 'ollama-app', actively polling /dev/mem."
echo "If Falco is a k8s workload: kubectl logs -n falco deploy/falco | grep /dev/mem"
echo "If Falco is a systemd service: journalctl -u falco-modern-bpf -f | grep -i '/dev/mem'"
