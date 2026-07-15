# Step 1: enable the admission plugin
# Edit /etc/kubernetes/manifests/kube-apiserver.yaml:
#   --enable-admission-plugins=NodeRestriction,ImagePolicyWebhook

# Step 2: point the API server to the admission config file
#   --admission-control-config-file=/etc/kubernetes/admission-config.yaml

# Step 3: admission config file
cat <<'YAML' > /etc/kubernetes/admission-config.yaml
apiVersion: apiserver.config.k8s.io/v1
kind: AdmissionConfiguration
plugins:
- name: ImagePolicyWebhook
  configuration:
    imagePolicy:
      kubeConfigFile: /etc/kubernetes/imagepolicy/kubeconfig.yaml
      allowTTL: 50
      denyTTL: 50
      retryBackoff: 500
      defaultAllow: false   # false = deny on webhook failure (the fix)
YAML

# Step 4: webhook kubeconfig must point to the correct webhook server
#   (name/URL given in the exam question) and reference valid client certs.

# Step 5: ensure both files are mounted into the kube-apiserver static pod
# (volumes + volumeMounts in the manifest), otherwise apiserver fails to start.

# Step 6: verify
ps -ef | grep kube-apiserver
kubectl get pods -n kube-system | grep apiserver
