#!/bin/bash
# Validation script for Question 6 - Ingress TLS + Redirect
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
echo " Validating Question 6: Ingress TLS + Redirect"
echo "======================================"

check "TLS secret 'my-tls' exists in namespace 'app-ns'" \
  kubectl get secret my-tls -n app-ns

check "Ingress 'secure-ingress' exists in namespace 'app-ns'" \
  kubectl get ingress secure-ingress -n app-ns

check "Ingress has ssl-redirect annotation set to true" \
  bash -c '[[ "$(kubectl get ingress secure-ingress -n app-ns -o jsonpath="{.metadata.annotations.nginx\.ingress\.kubernetes\.io/ssl-redirect}")" == "true" ]]'

check "Ingress references the TLS secret" \
  bash -c '[[ "$(kubectl get ingress secure-ingress -n app-ns -o jsonpath="{.spec.tls[0].secretName}")" == "my-tls" ]]'

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
