#!/bin/bash
# Validation script for Question 9 - Projected Volume + ServiceAccount
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
echo " Validating Question 9: Projected Volume + ServiceAccount"
echo "======================================"

check "Pod 'sa-demo-pod' exists in namespace 'sa-demo'" \
  kubectl get pod sa-demo-pod -n sa-demo

check "automountServiceAccountToken is false" \
  bash -c '[[ "$(kubectl get pod sa-demo-pod -n sa-demo -o jsonpath="{.spec.automountServiceAccountToken}")" == "false" ]]'

check "Pod has a projected volume with serviceAccountToken source" \
  bash -c 'kubectl get pod sa-demo-pod -n sa-demo -o json | grep -q serviceAccountToken'

check "Pod is Running" \
  bash -c '[[ "$(kubectl get pod sa-demo-pod -n sa-demo -o jsonpath="{.status.phase}")" == "Running" ]]'

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
