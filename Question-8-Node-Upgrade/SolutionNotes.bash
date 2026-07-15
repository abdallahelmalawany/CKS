# Step 1: drain the node (from the control-plane host)
kubectl drain compute-0 --ignore-daemonsets --delete-emptydir-data

# Step 2: SSH into the node
ssh compute-0

# --- inside the node ---
# Step 3: upgrade kubeadm
apt-cache madison kubeadm
apt-get update
apt-get install -y kubeadm=<VERSION>-00

# Step 4: run kubeadm upgrade node
kubeadm upgrade node

# Step 5: upgrade kubelet and kubectl
apt-get install -y kubelet=<VERSION>-00 kubectl=<VERSION>-00
systemctl daemon-reload
systemctl restart kubelet

# Step 6: exit back to control plane
exit
# --- back on control plane ---

# Step 7: uncordon the node
kubectl uncordon compute-0

# Verify
kubectl get nodes -o wide
