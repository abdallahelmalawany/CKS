# Mental shortcut: CIS finding + API server = edit the static pod manifest
# /etc/kubernetes/manifests/kube-apiserver.yaml, save, kubelet restarts it
# automatically. Never kubectl edit/patch this.

# Step 1: run kube-bench (optional, to see the actual finding)
kube-bench run --targets master --check 1.2.20

# Step 2: edit the API server static pod manifest
vi /etc/kubernetes/manifests/kube-apiserver.yaml
# Forbid anonymous authentication:
#   - --anonymous-auth=false
# Use authorization mode Node,RBAC (remove AlwaysAllow if present):
#   - --authorization-mode=Node,RBAC
# Enable NodeRestriction admission controller (append if others exist):
#   - --enable-admission-plugins=NodeRestriction
#   - --enable-admission-plugins=NamespaceLifecycle,ServiceAccount,NodeRestriction

# Step 3: save and let kubelet restart the API server automatically

# Step 4: switch kubectl to the secured config
export KUBECONFIG=/etc/kubernetes/admin.conf
kubectl get nodes

# Step 5: remove the insecure ClusterRoleBinding
kubectl delete clusterrolebinding system:anonymous
kubectl get clusterrolebinding | grep anonymous   # expect no output

# Step 6: quick validation
grep -n "anonymous-auth" /etc/kubernetes/manifests/kube-apiserver.yaml
grep -n "authorization-mode" /etc/kubernetes/manifests/kube-apiserver.yaml
grep -n "NodeRestriction" /etc/kubernetes/manifests/kube-apiserver.yaml
ps -ef | grep kube-apiserver
