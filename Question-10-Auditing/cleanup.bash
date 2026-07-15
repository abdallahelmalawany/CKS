#!/bin/bash
# Cleanup script for Question 10 - Auditing
set -uo pipefail
echo "Cleaning up Question 10: Auditing..."
echo "NOTE: reverting kube-apiserver.yaml audit flags manually is safer than a"
echo "blind sed here. Restore from your own backup if you made one."
rm -rf /etc/kubernetes/logpolicy
rm -f /var/log/kubernetes/audit-logs.txt*
echo "[OK] Question 10 cleanup complete (policy file + logs removed)"
