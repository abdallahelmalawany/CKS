#!/bin/bash
# Validation script for Question 7 - ImagePolicyWebhook
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

MANIFEST=/etc/kubernetes/manifests/kube-apiserver.yaml

echo "======================================"
echo " Validating Question 7: ImagePolicyWebhook"
echo "======================================"

check "ImagePolicyWebhook is in --enable-admission-plugins" \
  bash -c "grep -q 'enable-admission-plugins=.*ImagePolicyWebhook' '$MANIFEST'"

check "--admission-control-config-file flag is set" \
  bash -c "grep -q -- '--admission-control-config-file=' '$MANIFEST'"

check "Admission config file exists" \
  test -f /etc/kubernetes/admission-config.yaml

check "defaultAllow is set to false (deny on webhook failure)" \
  bash -c "grep -q 'defaultAllow: false' /etc/kubernetes/admission-config.yaml"

check "API server is running (static pod healthy)" \
  bash -c "kubectl get pods -n kube-system -l component=kube-apiserver -o jsonpath='{.items[0].status.phase}' | grep -q Running"

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
