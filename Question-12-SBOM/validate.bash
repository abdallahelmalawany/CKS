#!/bin/bash
# Validation script for Question 12 - SBOM
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
echo " Validating Question 12: SBOM"
echo "======================================"

check "SPDX SBOM file was generated" \
  test -f /home/candidate/alpine.spdx

check "Deployment 'alpine' now has exactly 2 containers" \
  bash -c '[[ $(kubectl -n alpine get deploy alpine -o jsonpath="{.spec.template.spec.containers[*].name}" | wc -w) -eq 2 ]]'

check "Vulnerable alpine:3.16.1 image (libcrypto3-3.1.4-r5) no longer referenced" \
  bash -c '! kubectl -n alpine get deploy alpine -o jsonpath="{.spec.template.spec.containers[*].image}" | grep -q "alpine:3.16.1"'

check "Deployment is available" \
  bash -c '[[ $(kubectl -n alpine get deploy alpine -o jsonpath="{.status.availableReplicas}") -ge 1 ]]'

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
echo "NOTE: this validator assumes alpine:3.16.1 is the vulnerable tag used in"
echo "LabSetUp.bash. If your actual exam gives different tags, verify manually."
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
