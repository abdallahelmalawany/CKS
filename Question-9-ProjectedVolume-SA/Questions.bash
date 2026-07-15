# Question:
# Use a projected volume to mount short-lived ServiceAccount tokens manually,
# instead of relying on the default auto-mounted (long-lived) token.

#Task
# 1. Set automountServiceAccountToken: false (on the ServiceAccount or the Pod).
# 2. Add a projected volume with a serviceAccountToken source that issues a
#    short-lived, audience-scoped token.

#Documentation Reference
# https://kubernetes.io/docs/tasks/configure-pod-container/configure-service-account/
