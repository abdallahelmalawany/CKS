# Edit ~/sa-pod.yaml:
#
# apiVersion: v1
# kind: Pod
# metadata:
#   name: sa-demo-pod
#   namespace: sa-demo
# spec:
#   serviceAccountName: demo-sa
#   automountServiceAccountToken: false     # disable default long-lived token
#   containers:
#   - name: app
#     image: busybox
#     command: ["sleep", "3600"]
#     volumeMounts:
#     - name: sa-token
#       mountPath: /var/run/secrets/tokens
#   volumes:
#   - name: sa-token
#     projected:
#       sources:
#       - serviceAccountToken:
#           audience: api
#           path: token
#           expirationSeconds: 3600

kubectl apply -f ~/sa-pod.yaml
