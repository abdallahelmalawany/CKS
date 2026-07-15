#!/bin/bash
# Creates a sample vulnerable Dockerfile + deployment.yaml to practice on.
set -e
mkdir -p /home/candidate/subtle-bee/build

cat <<'DOCKERFILE' > /home/candidate/subtle-bee/build/Dockerfile
FROM alpine:3.19
RUN apk add --no-cache curl
WORKDIR /app
COPY . /app
USER root
CMD ["./start.sh"]
DOCKERFILE

cat <<'DEPLOY' > /home/candidate/subtle-bee/deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: subtle-bee
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      app: subtle-bee
  template:
    metadata:
      labels:
        app: subtle-bee
    spec:
      containers:
      - name: subtle-bee
        image: alpine:3.19
        securityContext:
          readOnlyRootFilesystem: false
          allowPrivilegeEscalation: false
          privileged: false
DEPLOY

echo "[OK] Created /home/candidate/subtle-bee/build/Dockerfile (USER root = the bug)"
echo "[OK] Created /home/candidate/subtle-bee/deployment.yaml (readOnlyRootFilesystem: false = the bug)"
