# Question:
# Migrate an existing namespace to mutual TLS (mTLS) using Istio.

#Task
# 1. Enable sidecar injection for the namespace.
# 2. Apply a PeerAuthentication resource enforcing STRICT mTLS mode.

#Note
# Requires Istio already installed on the cluster (istioctl install).
# Killercoda's killer-shell-cks playground does not ship Istio by default --
# install a minimal profile first if it's not there.

#Documentation Reference
# https://istio.io/latest/docs/tasks/security/authentication/mtls-migration/
# https://istio.io/latest/docs/setup/additional-setup/sidecar-injection/
