#!/bin/bash
# Cleanup script for Question 11 - Docker Daemon Security
set -uo pipefail
echo "Cleaning up Question 11: Docker Daemon Security..."

userdel -r developer 2>/dev/null || true
rm -f /etc/systemd/system/docker.service.d/override.conf
systemctl daemon-reload
systemctl restart docker || true

echo "[OK] Question 11 cleanup complete"
