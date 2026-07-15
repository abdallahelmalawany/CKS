#!/bin/bash
# Validation script for Question 2 - TLS Secret
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
echo " Validating Question 2: TLS Secret"
echo "======================================"

check "Secret 'clever-cactus' exists in namespace 'clever-cactus'" \
  kubectl get secret clever-cactus -n clever-cactus

check "Secret type is kubernetes.io/tls" \
  bash -c '[[ "$(kubectl get secret clever-cactus -n clever-cactus -o jsonpath="{.type}")" == "kubernetes.io/tls" ]]'

check "Secret has tls.crt and tls.key data keys" \
  bash -c 'kubectl get secret clever-cactus -n clever-cactus -o jsonpath="{.data.tls\.crt}{.data.tls\.key}" | grep -q .'

check "Deployment clever-cactus is available" \
  bash -c '[[ $(kubectl get deployment clever-cactus -n clever-cactus -o jsonpath="{.status.availableReplicas}") -ge 1 ]]'

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
