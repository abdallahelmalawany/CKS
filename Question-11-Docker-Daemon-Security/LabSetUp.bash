#!/bin/bash
set -e

echo "Creating vulnerable 'developer' user in the docker group..."
id -u developer &>/dev/null || useradd -m developer
usermod -aG docker developer

echo "Loosening docker.sock ownership..."
chown root:docker /var/run/docker.sock || true
chmod 666 /var/run/docker.sock || true

echo "Exposing Docker over TCP (insecure) via systemd override..."
mkdir -p /etc/systemd/system/docker.service.d
cat <<'CONF' > /etc/systemd/system/docker.service.d/override.conf
[Service]
ExecStart=
ExecStart=/usr/bin/dockerd -H fd:// -H tcp://0.0.0.0:2375 --containerd=/run/containerd/containerd.sock
CONF

systemctl daemon-reload
systemctl restart docker || echo "!! docker restart may need manual check on this playground"

echo "[OK] Verify vulnerable state with:"
echo "   id developer   (should show docker group)"
echo "   ss -lntp | grep dockerd   (should show :2375 listening)"
