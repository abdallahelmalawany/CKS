# Question:
# You must address the issues identified by the CIS Benchmark tool for the
# kubeadm-provisioned cluster.

#Task
# Fix the configuration issues and restart the affected components so the new
# settings are applied.
# Resolve the following issues identified with the Kubelet configuration:
#   1. The cluster is using Docker Engine as its container runtime. If
#      necessary, use the docker command to troubleshoot running containers.
#   2. Ensure the --anonymous-auth argument is explicitly set to false.
#   3. Ensure the --authorization-mode argument is not set to AlwaysAllow.
# Use Webhook authentication and authorization mechanisms whenever possible to
# enhance security and centralize access control.
# Address the following security violation related to etcd:
#   1. Ensure the --client-cert-auth argument is explicitly set to true.
#
# Specific sub-scenario: secure the Kubelet on node node01:
#   1. Disable Anonymous Authentication.
#   2. Enable Webhook Authorization.
#   3. Ensure the Kubelet service is restarted and verified.

#Documentation Reference
# https://kubernetes.io/docs/reference/access-authn-authz/kubelet-authn-authz/
