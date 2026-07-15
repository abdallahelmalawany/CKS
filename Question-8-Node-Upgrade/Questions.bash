# Question:
# WARNING: You must connect to the correct host. Failure to do so may result
# in zero points. ssh cks000034
#
# Context: The kubeadm-provisioned cluster was recently upgraded, leaving one
# node on a slightly older version due to workload compatibility concerns.

#Task
# Upgrade the cluster node compute-0 to match the version of the control
# plane node.
# Use a command like the following to connect to the compute node:
#   ssh compute-0
# Do not modify any running workloads in the cluster.
# Do not forget to exit from the compute node once you have completed your
# tasks: exit

#Note
# No LabSetUp.bash for this one -- deliberately downgrading kubeadm/kubelet
# on a Killercoda node is risky and Killercoda's playground usually has
# limited/no package repo access anyway. Practice the *procedure* against
# whatever versions are already there, or use a local kind/minikube
# multi-node cluster with two kubeadm package versions available.

#Documentation Reference
# https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/upgrading-linux-nodes/
