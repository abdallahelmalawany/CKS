# Edit ~/sec-ns_deployment.yaml, add under spec.template.spec.containers[0]:
#
# securityContext:
#   runAsUser: 30000               # Use user ID 30000
#   readOnlyRootFilesystem: true    # Use a read-only root filesystem
#   allowPrivilegeEscalation: false # Prevent privilege escalation

kubectl apply -f ~/sec-ns_deployment.yaml
kubectl rollout status deployment/secdep -n sec-ns
