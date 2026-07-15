# Step 1: access the node
ssh node01

# Step 2: fix the kubelet config
sudo vi /var/lib/kubelet/config.yaml
# authentication:
#   anonymous:
#     enabled: false          # was true
#   webhook:
#     enabled: true            # needed for token/webhook auth
# authorization:
#   mode: Webhook               # was AlwaysAllow

# Step 3: restart kubelet
sudo systemctl daemon-reload
sudo systemctl restart kubelet

# Step 4: IMPORTANT - check for CLI flag overrides
ps -ef | grep kubelet
# If you see --anonymous-auth=true or --authorization-mode=AlwaysAllow in the
# actual running args, fix the source too:
#   /var/lib/kubelet/kubeadm-flags.env
#   /etc/default/kubelet

# Step 5: validate
curl -k https://localhost:10250/pods
# Expected: Unauthorized or 401. JSON pod data = still broken.

# Step 6: fix etcd --client-cert-auth (control-plane node, static pod)
sudo vi /etc/kubernetes/manifests/etcd.yaml
# - --client-cert-auth=true
# Just save -- kubelet restarts the static pod automatically.
