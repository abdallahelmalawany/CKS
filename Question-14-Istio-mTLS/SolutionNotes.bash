# Step 1: enable sidecar injection for the namespace
kubectl label namespace app-ns istio-injection=enabled
kubectl rollout restart deployment -n app-ns

# Step 2: apply PeerAuthentication for strict mTLS
cat <<'YAML' > peerauth-strict.yaml
apiVersion: security.istio.io/v1beta1
kind: PeerAuthentication
metadata:
  name: default
  namespace: app-ns
spec:
  mtls:
    mode: STRICT
YAML
kubectl apply -f peerauth-strict.yaml

# Verify
kubectl get pods -n app-ns -o jsonpath='{.items[*].spec.containers[*].name}'
# should now include "istio-proxy"
istioctl authn tls-check <pod> -n app-ns

# Optional: pair with an AuthorizationPolicy to restrict which services can talk
cat <<'YAML' > authz-allow-only-frontend.yaml
apiVersion: security.istio.io/v1beta1
kind: AuthorizationPolicy
metadata:
  name: allow-only-frontend
  namespace: app-ns
spec:
  selector:
    matchLabels:
      app: plain-app
  action: ALLOW
  rules:
  - from:
    - source:
        principals: ["cluster.local/ns/app-ns/sa/frontend"]
YAML
