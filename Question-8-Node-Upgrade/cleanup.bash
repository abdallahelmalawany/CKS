#!/bin/bash
# Cleanup script for Question 8 - Node Upgrade
set -uo pipefail
echo "Cleaning up Question 8: Node Upgrade..."
echo "Nothing to clean up -- this question doesn't create extra cluster resources."
echo "If the node was left cordoned, uncordon it:"
kubectl uncordon compute-0 2>/dev/null || true
echo "[OK] Question 8 cleanup complete"
