#!/bin/bash
# Validation script for Question 16 - Seccomp Profile
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
echo " Validating Question 16: Seccomp Profile"
echo "======================================"

check "Pod 'seccomp-demo' exists" \
  kubectl get pod seccomp-demo -n default

check "seccompProfile type is Localhost" \
  bash -c '[[ "$(kubectl get pod seccomp-demo -o jsonpath="{.spec.securityContext.seccompProfile.type}")" == "Localhost" ]]'

check "localhostProfile points to profiles/restrictive.json" \
  bash -c '[[ "$(kubectl get pod seccomp-demo -o jsonpath="{.spec.securityContext.seccompProfile.localhostProfile}")" == "profiles/restrictive.json" ]]'

check "Profile file exists on the node's seccomp root" \
  test -f /var/lib/kubelet/seccomp/profiles/restrictive.json

check "Pod is Running" \
  bash -c '[[ "$(kubectl get pod seccomp-demo -o jsonpath="{.status.phase}")" == "Running" ]]'

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
