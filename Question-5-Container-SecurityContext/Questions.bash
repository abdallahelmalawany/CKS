# Question:
# WARNING: You must connect to the correct host. Failure to do so may result
# in zero points.
#
# Context: You must update an existing Pod to ensure immutability of its
# containers.

#Task
# Modify the Deployment named secdep in the sec-ns namespace so that its
# containers:
#   - Use user ID 30000
#   - Use a read-only root filesystem
#   - Prevent privilege escalation
#
# You can find the Deployment manifest file at: ~/sec-ns_deployment.yaml

#Documentation Reference
# https://kubernetes.io/docs/tasks/configure-pod-container/security-context/
