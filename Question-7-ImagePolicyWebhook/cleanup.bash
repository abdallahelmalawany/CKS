#!/bin/bash
# Cleanup script for Question 7 - ImagePolicyWebhook
set -uo pipefail
echo "Cleaning up Question 7: ImagePolicyWebhook..."
echo "NOTE: reverting kube-apiserver.yaml flags manually is safer than scripting"
echo "a blind sed here -- restore from your own backup if you made one, e.g.:"
echo "  cp /etc/kubernetes/manifests/kube-apiserver.yaml.bak /etc/kubernetes/manifests/kube-apiserver.yaml"
rm -f /etc/kubernetes/admission-config.yaml
echo "[OK] Question 7 cleanup complete (admission-config.yaml removed)"
