#!/bin/bash
# Cleanup script for Question 2 - TLS Secret
set -uo pipefail
echo "Cleaning up Question 2: TLS Secret..."

kubectl delete secret clever-cactus -n clever-cactus --ignore-not-found

echo "[OK] Question 2 cleanup complete"
