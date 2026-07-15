# Question:
# You must secure access to a web server using SSL files stored in a TLS Secret.
#
# WARNING: You must connect to the correct host. Failure to do so may result
# in zero points. ssh cks000040

#Task
# Create a TLS Secret named clever-cactus in the clever-cactus namespace for
# an existing Deployment named clever-cactus.
# Use the following SSL files:
#   Certificate: /home/candidate/ca-cert/web.k8s.local.crt
#   Private Key: /home/candidate/ca-cert/web.k8s.local.key
# The Deployment is pre-configured to use the TLS Secret.
# Do not modify the existing Deployment.

#Killercoda scenario (ready-made, no LabSetUp.bash needed)
# https://killercoda.com/killer-shell-cks/scenario/ingress-secure

#Documentation Reference
# https://kubernetes.io/docs/concepts/configuration/secret/#tls-secrets
