# Edit ~/seccomp-pod.yaml:
#
# apiVersion: v1
# kind: Pod
# metadata:
#   name: seccomp-demo
#   namespace: default
# spec:
#   securityContext:
#     seccompProfile:
#       type: Localhost
#       localhostProfile: profiles/restrictive.json
#   containers:
#   - name: app
#     image: nginx:alpine

kubectl apply -f ~/seccomp-pod.yaml

# Notes:
# - localhostProfile is a RELATIVE path from the kubelet's seccomp root,
#   default /var/lib/kubelet/seccomp/. A profile physically at
#   /var/lib/kubelet/seccomp/profiles/restrictive.json is referenced as
#   profiles/restrictive.json.
# - The profile must exist on every node the pod could be scheduled to.
# - seccompProfile can be Pod-level (all containers) or per-container.

# Verify
kubectl get pod seccomp-demo -o jsonpath='{.spec.securityContext.seccompProfile}'
kubectl describe pod seccomp-demo | grep -A2 -i seccomp
