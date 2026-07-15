#!/bin/bash
# Validation script for Question 8 - Node Upgrade
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
echo " Validating Question 8: Node Upgrade"
echo "======================================"

CP_VERSION=$(kubectl get nodes -o jsonpath='{.items[?(@.metadata.labels.node-role\.kubernetes\.io/control-plane=="")].status.nodeInfo.kubeletVersion}' | head -1)
NODE_VERSION=$(kubectl get node compute-0 -o jsonpath='{.status.nodeInfo.kubeletVersion}' 2>/dev/null || echo "")

check "compute-0 node exists" \
  kubectl get node compute-0

check "compute-0 kubelet version matches control-plane version ($CP_VERSION)" \
  bash -c "[[ '$NODE_VERSION' == '$CP_VERSION' ]]"

check "compute-0 is schedulable (uncordoned)" \
  bash -c '[[ "$(kubectl get node compute-0 -o jsonpath="{.spec.unschedulable}")" != "true" ]]'

check "compute-0 is Ready" \
  bash -c 'kubectl get node compute-0 -o jsonpath="{.status.conditions[?(@.type==\"Ready\")].status}" | grep -q True'

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
