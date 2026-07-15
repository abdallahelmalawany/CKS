# Question:
# WARNING: You must connect to the correct host. Failure to do so may result
# in zero points. ssh cks000031
#
# Context: You must implement NetworkPolicies controlling the traffic flow of
# existing Deployments across namespaces.

#Task
# 1. Create a NetworkPolicy named deny-policy in the prod namespace to block
#    all ingress traffic. The prod namespace is labeled env: prod.
# 2. Create a NetworkPolicy named allow-from-prod in the data namespace to
#    allow ingress traffic only from Pods in the prod namespace (via the
#    namespace's env label). The data namespace is labeled env: data.
#
# Do not modify or delete any namespaces or Pods. Only create the required
# NetworkPolicies.

#Killercoda scenario (default-deny pattern, similar setup)
# https://killercoda.com/killer-shell-cks/scenario/networkpolicy-create-default-deny

#Documentation Reference
# https://kubernetes.io/docs/concepts/services-networking/network-policies/
