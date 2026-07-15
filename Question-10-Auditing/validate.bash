#!/bin/bash
# Validation script for Question 10 - Auditing
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

MANIFEST=/etc/kubernetes/manifests/kube-apiserver.yaml

echo "======================================"
echo " Validating Question 10: Auditing"
echo "======================================"

check "Audit policy file exists" \
  test -f /etc/kubernetes/logpolicy/sample-policy.yaml

check "--audit-policy-file flag is set correctly" \
  bash -c "grep -q -- '--audit-policy-file=/etc/kubernetes/logpolicy/sample-policy.yaml' '$MANIFEST'"

check "--audit-log-path flag is set correctly" \
  bash -c "grep -q -- '--audit-log-path=/var/log/kubernetes/audit-logs.txt' '$MANIFEST'"

check "--audit-log-maxage is 10" \
  bash -c "grep -q -- '--audit-log-maxage=10' '$MANIFEST'"

check "--audit-log-maxbackup is 2" \
  bash -c "grep -q -- '--audit-log-maxbackup=2' '$MANIFEST'"

check "Audit log file has been written to" \
  test -s /var/log/kubernetes/audit-logs.txt

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
