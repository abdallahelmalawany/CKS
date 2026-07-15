# Question:
# Create an Ingress resource that terminates TLS using an existing secret and
# redirects all HTTP requests to HTTPS.

#Task
# 1. Create the TLS secret from provided cert/key files.
# 2. Apply an Ingress manifest with ingressClassName: nginx and annotation
#    nginx.ingress.kubernetes.io/ssl-redirect: "true"
#
# Test:
#   curl -vvv https://...   # should see the cert details
#   curl -vvv http://...    # should see a redirect

#Killercoda scenario (ready-made, no LabSetUp.bash needed)
# https://killercoda.com/killer-shell-cks/scenario/ingress-secure

#Documentation Reference
# https://kubernetes.io/docs/concepts/services-networking/ingress/#tls
