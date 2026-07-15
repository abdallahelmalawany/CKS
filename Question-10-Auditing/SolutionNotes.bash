# Step 1: create the audit policy file
mkdir -p /etc/kubernetes/logpolicy
cat <<'YAML' > /etc/kubernetes/logpolicy/sample-policy.yaml
apiVersion: audit.k8s.io/v1
kind: Policy
rules:
- level: RequestResponse
  resources:
  - group: ""
    resources: ["namespaces"]
- level: Request
  namespaces: ["front-apps"]
  resources:
  - group: ""
    resources: ["persistentvolumeclaims"]
- level: Metadata
  resources:
  - group: ""
    resources: ["configmaps", "secrets"]
- level: Metadata
YAML

# Step 2: update the kube-apiserver static pod manifest
# /etc/kubernetes/manifests/kube-apiserver.yaml -- add flags:
#   --audit-policy-file=/etc/kubernetes/logpolicy/sample-policy.yaml
#   --audit-log-path=/var/log/kubernetes/audit-logs.txt
#   --audit-log-maxage=10
#   --audit-log-maxbackup=2
#
# Also add matching volumes + volumeMounts for:
#   /etc/kubernetes/logpolicy  (policy dir)
#   /var/log/kubernetes        (log output dir)

# Step 3: save -- kubelet restarts the API server automatically (static pod)

# Step 4: verify
ps -ef | grep kube-apiserver | grep audit
ls -l /var/log/kubernetes/audit-logs.txt
tail -f /var/log/kubernetes/audit-logs.txt
