cat <<'YAML' > deny-ingress-prod.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: deny-policy
  namespace: prod
spec:
  podSelector: {}
  policyTypes:
  - Ingress
YAML

cat <<'YAML' > allow-ingress-from-prod.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-from-prod
  namespace: data
spec:
  podSelector: {}
  policyTypes:
  - Ingress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          env: prod
YAML

kubectl apply -f deny-ingress-prod.yaml
kubectl apply -f allow-ingress-from-prod.yaml

# Test
kubectl exec -it default -- curl -vvv prod.prod.svc.cluster.local     # should hang
kubectl exec -n prod -it prod -- curl -vvv data.data.svc.cluster.local # should work
kubectl exec -n default -it default -- curl -vvv data.data.svc.cluster.local # should hang
