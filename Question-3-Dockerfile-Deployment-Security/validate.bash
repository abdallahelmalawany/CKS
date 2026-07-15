#!/bin/bash
# Validation script for Question 3 - Dockerfile & Deployment Security
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

DOCKERFILE=/home/candidate/subtle-bee/build/Dockerfile
DEPLOYFILE=/home/candidate/subtle-bee/deployment.yaml

echo "======================================"
echo " Validating Question 3: Dockerfile & Deployment Security"
echo "======================================"

check "Dockerfile no longer runs as USER root" \
  bash -c "! grep -qE '^USER\s+root\s*\$' '$DOCKERFILE'"

check "Dockerfile still has exactly one USER instruction" \
  bash -c "[[ \$(grep -c '^USER' '$DOCKERFILE') -eq 1 ]]"

check "Dockerfile instruction count unchanged (6 lines)" \
  bash -c "[[ \$(grep -cve '^\s*\$' '$DOCKERFILE') -eq 6 ]]"

check "deployment.yaml readOnlyRootFilesystem is not 'false' anymore (if that was the fix)" \
  bash -c "! grep -q 'readOnlyRootFilesystem: false' '$DEPLOYFILE'"

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
echo "NOTE: this validator can only check for obviously-wrong patterns -- always"
echo "eyeball your diff against SolutionNotes.bash too."
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
