#!/bin/bash
# Validation script for Question 15 - CIS Benchmark / kube-bench
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
echo " Validating Question 15: CIS Benchmark"
echo "======================================"

check "--anonymous-auth=false is set" \
  bash -c "grep -q -- '--anonymous-auth=false' '$MANIFEST'"

check "--authorization-mode=Node,RBAC is set (no AlwaysAllow)" \
  bash -c "grep -q -- '--authorization-mode=Node,RBAC' '$MANIFEST' && ! grep -q AlwaysAllow '$MANIFEST'"

check "NodeRestriction is in --enable-admission-plugins" \
  bash -c "grep -q -- '--enable-admission-plugins=.*NodeRestriction' '$MANIFEST'"

check "system:anonymous ClusterRoleBinding has been removed" \
  bash -c "! kubectl --kubeconfig=/etc/kubernetes/admin.conf get clusterrolebinding | grep -q anonymous"

check "API server is reachable via secured kubeconfig" \
  bash -c "kubectl --kubeconfig=/etc/kubernetes/admin.conf get nodes"

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
