# Question:
# WARNING: You must connect to the correct host. Failure to do so may result
# in zero points.
#
# Context: For testing purposes, the kubeadm-provisioned cluster's API server
# was configured to allow unauthenticated and unauthorized access.

#Task
# First, secure the cluster's API server, configuring it as follows:
#   1. Forbid anonymous authentication.
#   2. Use authorization mode Node,RBAC.
#   3. Use admission controller NodeRestriction.
#
# The cluster uses the Docker Engine as its container runtime. If needed, use
# the docker command to troubleshoot running containers.
#
# kubectl is configured to use unauthenticated and unauthorized access -- you
# do not have to change it, but be aware that kubectl will stop working once
# you've secured the cluster.
#
# You can use the cluster's original kubectl configuration file located at
# /etc/kubernetes/admin.conf to access the secured cluster.
#
# Next, to clean up, remove the ClusterRoleBinding system:anonymous.

#Documentation Reference
# https://kubernetes.io/docs/reference/access-authn-authz/authentication/
