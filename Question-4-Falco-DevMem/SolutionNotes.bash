# Step 1: verify Falco is running
kubectl get pods -n falco               # if installed as a k8s workload
which falco; systemctl status falco     # if installed as a systemd service

# Step 2: check Falco alerts for the rule trigger
kubectl logs -n falco deploy/falco | grep /dev/mem
# or
journalctl -u falco-modern-bpf -f | grep -i "/dev/mem"
# or
cat /var/log/syslog | grep falco | grep devmem

# Step 3: locate the Deployment that owns the offending pod
kubectl get pods -n ollama-app <pod_name> -o jsonpath='{.metadata.ownerReferences[0].name}'
kubectl get deploy -n ollama-app

# Step 4: scale it to zero -- and ONLY that
kubectl scale deploy ollama -n ollama-app --replicas=0

# Do not delete the Deployment. Do not touch any other Deployment or field.
