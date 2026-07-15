# Step 1: remove user from the docker group
sudo gpasswd -d developer docker

# Step 2: fix Docker socket ownership
sudo chown root:root /var/run/docker.sock

# Step 3: remove the TCP listener
systemctl cat docker.service | sed -n '1,200p'
sudo systemctl edit docker.service
# [Service]
# ExecStart=
# ExecStart=/usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock

sudo systemctl daemon-reload
sudo systemctl restart docker.socket docker.service

# Step 4: also check /etc/docker/daemon.json if TCP is configured there:
#   { "hosts": ["unix:///var/run/docker.sock"] }

# Step 5: verify
ss -lntp | grep dockerd || true      # expect: no output
ps -ef | grep dockerd | grep -v grep # expect: only -H fd://, no tcp://
id developer                          # expect: no 'docker' group
