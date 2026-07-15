# Step 0: setup
ssh cks000035
sudo -i
export KUBECONFIG=/etc/kubernetes/admin.conf

# Step 1: list the 3 container names + images
kubectl -n alpine get deploy alpine -o \
  jsonpath='{range .spec.template.spec.containers[*]}{.name}{"\t"}{.image}{"\n"}{end}'

# Step 2: identify which image has the vulnerable libcrypto3
docker run --rm alpine:3.20.0 sh -c 'apk info -v libcrypto3 2>/dev/null | head -n1'
docker run --rm alpine:3.19.6 sh -c 'apk info -v libcrypto3 2>/dev/null | head -n1'
docker run --rm alpine:3.16.1 sh -c 'apk info -v libcrypto3 2>/dev/null | head -n1'
# The vulnerable image prints exactly: libcrypto3-3.1.4-r5
IMG=alpine:3.xx   # whichever matched

# Step 3: generate the SPDX SBOM for that image
bom generate --image $IMG --format spdx --output /home/candidate/alpine.spdx
ls -l /home/candidate/alpine.spdx

# Step 4: remove ONLY that container from the Deployment
vi /home/candidate/alpine-deployment.yaml
# delete the one container block whose image: equals $IMG -- leave the other two.

# Step 5: apply and verify
kubectl apply -f /home/candidate/alpine-deployment.yaml
kubectl -n alpine rollout status deployment/alpine
kubectl -n alpine get deploy alpine -o \
  jsonpath='{range .spec.template.spec.containers[*]}{.name}{"\t"}{.image}{"\n"}{end}'
