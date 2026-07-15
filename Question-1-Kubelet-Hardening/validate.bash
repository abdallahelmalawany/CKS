#!/bin/bash
# Validation script for Question 1 - Kubelet Hardening
set -uo pipefail

PASS=0
FAIL=0
TOTAL=0

check() {
  local description="$1"
  shift
  TOTAL=$((TOTAL + 1))
  if "$@" >/dev/null 2>&1; then
    echo "  PASS: $description"
    PASS=$((PASS + 1))
  else
    echo "  FAIL: $description"
    FAIL=$((FAIL + 1))
  fi
}

echo "======================================"
echo " Validating Question 1: Kubelet Hardening"
echo "======================================"

check "kubelet config.yaml has anonymous auth disabled" \
  bash -c "grep -A2 '^authentication:' /var/lib/kubelet/config.yaml | grep -A1 'anonymous:' | grep -q 'enabled: false'"

check "kubelet config.yaml has webhook auth enabled" \
  bash -c "grep -A2 'webhook:' /var/lib/kubelet/config.yaml | grep -q 'enabled: true'"

check "kubelet config.yaml authorization mode is Webhook" \
  bash -c "grep -A1 '^authorization:' /var/lib/kubelet/config.yaml | grep -q 'mode: Webhook'"

check "kubelet API server rejects anonymous requests (401/Unauthorized)" \
  bash -c "curl -sk https://localhost:10250/pods | grep -qi 'unauthorized'"

check "kubelet process running with no --anonymous-auth=true flag override" \
  bash -c "! ps -ef | grep kubelet | grep -v grep | grep -q -- '--anonymous-auth=true'"

check "etcd static pod manifest has --client-cert-auth=true" \
  bash -c "grep -q -- '--client-cert-auth=true' /etc/kubernetes/manifests/etcd.yaml"

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
