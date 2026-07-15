# Step 1: create the TLS secret
kubectl create secret tls my-tls --cert=cert.crt --key=cert.key -n app-ns

# Step 2: apply the Ingress manifest
cat <<'YAML' > secure-ingress.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: secure-ingress
  namespace: app-ns
  annotations:
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
spec:
  ingressClassName: nginx
  tls:
  - hosts:
    - web.k8s.local
    secretName: my-tls
  rules:
  - host: web.k8s.local
    http:
      paths:
      - path: /
        pathType: Prefix
        backend:
          service:
            name: my-svc
            port:
              number: 80
YAML
kubectl apply -f secure-ingress.yaml

# Step 3: test
curl -vvv https://web.k8s.local     # should show cert details
curl -vvv http://web.k8s.local      # should show a redirect (301/308) to https
