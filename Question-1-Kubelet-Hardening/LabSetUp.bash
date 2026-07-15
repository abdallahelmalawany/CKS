#!/bin/bash
# Deliberately misconfigures the kubelet + etcd to recreate the exam scenario.
# Run this ON THE NODE (e.g. node01 on Killercoda) as root.
set -e

echo "Backing up current kubelet config..."
cp /var/lib/kubelet/config.yaml /var/lib/kubelet/config.yaml.bak 2>/dev/null || true

echo "Injecting insecure kubelet settings..."
cat <<'CFG' >> /var/lib/kubelet/config.yaml
# --- injected by LabSetUp.bash for practice, remove/fix these ---
authentication:
  anonymous:
    enabled: true
  webhook:
    enabled: false
authorization:
  mode: AlwaysAllow
CFG

echo "Restarting kubelet with the vulnerable config..."
systemctl daemon-reload
systemctl restart kubelet

echo "Flipping etcd --client-cert-auth to false (control-plane node only)..."
if [ -f /etc/kubernetes/manifests/etcd.yaml ]; then
  sed -i 's/--client-cert-auth=true/--client-cert-auth=false/' /etc/kubernetes/manifests/etcd.yaml
fi

echo "[OK] Lab setup complete. Cluster is now intentionally insecure. Go fix it!"
