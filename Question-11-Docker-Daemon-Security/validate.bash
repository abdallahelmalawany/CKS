#!/bin/bash
# Validation script for Question 11 - Docker Daemon Security
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
echo " Validating Question 11: Docker Daemon Security"
echo "======================================"

check "'developer' user is NOT in the docker group" \
  bash -c '! id developer | grep -q docker'

check "docker.sock is owned by root:root" \
  bash -c '[[ "$(stat -c "%U:%G" /var/run/docker.sock)" == "root:root" ]]'

check "Docker is not listening on TCP port 2375" \
  bash -c '! ss -lntp | grep -q dockerd.*2375'

check "dockerd process has no -H tcp:// flag" \
  bash -c '! ps -ef | grep dockerd | grep -v grep | grep -q "tcp://"'

echo ""
echo "Results: $PASS/$TOTAL passed, $FAIL failed"
[[ $FAIL -eq 0 ]] && echo "All checks passed!" || echo "Some checks failed."
exit $FAIL
