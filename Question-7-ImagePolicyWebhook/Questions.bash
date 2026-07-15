# Question:
# Reject unsigned/untrusted images before they reach the cluster.

#Task
# 1. Given a rule and policy under a specific path ("kubeconfig at the same path").
# 2. Apply this policy on the cluster's API server.
# 3. Flip the default behavior from true (allow) to false (deny) on webhook failure.
# 4. Put the correct server name in the config.

#Killercoda scenario (ready-made, no LabSetUp.bash needed)
# https://killercoda.com/killer-shell-cks/scenario/image-policy-webhook-setup

#Documentation Reference
# https://kubernetes.io/docs/reference/access-authn-authz/admission-controllers/#imagepolicywebhook
