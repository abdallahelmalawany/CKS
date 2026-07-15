#!/bin/bash
# Validation script for Question 4 - Falco /dev/mem detection
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
echo " Validating Question 4: Falco /dev/mem"
echo "======================================"

check "Deployment 'ollama' still exists (not deleted)" \
  kubectl get deployment ollama -n ollama-app

check "Deployment 'ollama' is scaled to 0 replicas" \
  bash -c '[[ "$(kubectl get deployment ollama -n ollama-app -o jsonpath="{.spec.replicas}")" == "0" ]]'

check "No 'ollama' pods currently running" \
  bash -c '[[ -z "$(kubectl get pods -n ollama-app -l app=ollama --field-selector=status.phase=Running -o name)" ]]'

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
