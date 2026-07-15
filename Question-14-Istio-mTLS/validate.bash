#!/bin/bash
# Validation script for Question 14 - Istio mTLS
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
echo " Validating Question 14: Istio mTLS"
echo "======================================"

check "Namespace 'app-ns' has istio-injection=enabled label" \
  bash -c '[[ "$(kubectl get ns app-ns -o jsonpath="{.metadata.labels.istio-injection}")" == "enabled" ]]'

check "plain-app pod has istio-proxy sidecar container" \
  bash -c 'kubectl get pods -n app-ns -l app=plain-app -o jsonpath="{.items[0].spec.containers[*].name}" | grep -q istio-proxy'

check "PeerAuthentication 'default' exists in app-ns with STRICT mode" \
  bash -c '[[ "$(kubectl get peerauthentication default -n app-ns -o jsonpath="{.spec.mtls.mode}")" == "STRICT" ]]'

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
