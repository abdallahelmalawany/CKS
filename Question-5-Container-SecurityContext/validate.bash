#!/bin/bash
# Validation script for Question 5 - Container Security Context
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
echo " Validating Question 5: Container Security Context"
echo "======================================"

check "Deployment 'secdep' exists in namespace 'sec-ns'" \
  kubectl get deployment secdep -n sec-ns

check "runAsUser is 30000" \
  bash -c '[[ "$(kubectl get deployment secdep -n sec-ns -o jsonpath="{.spec.template.spec.containers[0].securityContext.runAsUser}")" == "30000" ]]'

check "readOnlyRootFilesystem is true" \
  bash -c '[[ "$(kubectl get deployment secdep -n sec-ns -o jsonpath="{.spec.template.spec.containers[0].securityContext.readOnlyRootFilesystem}")" == "true" ]]'

check "allowPrivilegeEscalation is false" \
  bash -c '[[ "$(kubectl get deployment secdep -n sec-ns -o jsonpath="{.spec.template.spec.containers[0].securityContext.allowPrivilegeEscalation}")" == "false" ]]'

check "Deployment has at least 1 available replica" \
  bash -c '[[ $(kubectl get deployment secdep -n sec-ns -o jsonpath="{.status.availableReplicas}") -ge 1 ]]'

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
