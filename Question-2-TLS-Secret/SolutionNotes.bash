kubectl create secret tls clever-cactus \
  --cert=/home/candidate/ca-cert/web.k8s.local.crt \
  --key=/home/candidate/ca-cert/web.k8s.local.key \
  -n clever-cactus

# Verify
kubectl get secret clever-cactus -n clever-cactus
kubectl describe secret clever-cactus -n clever-cactus
kubectl rollout status deployment/clever-cactus -n clever-cactus
