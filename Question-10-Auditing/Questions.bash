# Question:
# Enable and verify Kubernetes API server auditing.

#Task
# Enable audit logging on the Kubernetes API server.
#   - Use audit policy file at /etc/kubernetes/logpolicy/sample-policy.yaml.
#   - Write logs to /var/log/kubernetes/audit-logs.txt.
#   - Set log retention to 10 days and keep a maximum of 2 old log files.
#   - Policy requirements:
#       * Log namespace changes at RequestResponse.
#       * Log PersistentVolumeClaim changes in namespace front-apps at Request.
#       * Log ConfigMap and Secret changes at Metadata.
#       * Log all other requests at Metadata.

#Killercoda scenario (ready-made, no LabSetUp.bash needed)
# https://killercoda.com/killer-shell-cks/scenario/auditing-enable-audit-logs

#Documentation Reference
# https://kubernetes.io/docs/tasks/debug/debug-cluster/audit/
