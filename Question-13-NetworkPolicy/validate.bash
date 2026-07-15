#!/bin/bash
# Validation script for Question 13 - Network Policy
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
echo " Validating Question 13: Network Policy"
echo "======================================"

check "NetworkPolicy 'deny-policy' exists in namespace 'prod'" \
  kubectl get networkpolicy deny-policy -n prod

check "deny-policy has empty podSelector (applies to all pods)" \
  bash -c '[[ "$(kubectl get networkpolicy deny-policy -n prod -o jsonpath="{.spec.podSelector}")" == "{}" ]]'

check "deny-policy blocks Ingress with no allow rules" \
  bash -c '[[ -z "$(kubectl get networkpolicy deny-policy -n prod -o jsonpath="{.spec.ingress}")" ]]'

check "NetworkPolicy 'allow-from-prod' exists in namespace 'data'" \
  kubectl get networkpolicy allow-from-prod -n data

check "allow-from-prod allows ingress from namespaces labeled env=prod" \
  bash -c 'kubectl get networkpolicy allow-from-prod -n data -o json | grep -q "\"env\":\"prod\""'

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
