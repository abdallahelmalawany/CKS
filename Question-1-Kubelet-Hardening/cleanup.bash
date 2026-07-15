#!/bin/bash
# Cleanup script for Question 1 - Kubelet Hardening
set -uo pipefail
echo "Cleaning up Question 1: Kubelet Hardening..."

if [ -f /var/lib/kubelet/config.yaml.bak ]; then
  cp /var/lib/kubelet/config.yaml.bak /var/lib/kubelet/config.yaml
  rm -f /var/lib/kubelet/config.yaml.bak
  systemctl daemon-reload
  systemctl restart kubelet
  echo "Restored original kubelet config.yaml"
fi

if [ -f /etc/kubernetes/manifests/etcd.yaml ]; then
  sed -i 's/--client-cert-auth=false/--client-cert-auth=true/' /etc/kubernetes/manifests/etcd.yaml
fi

echo "[OK] Question 1 cleanup complete"
