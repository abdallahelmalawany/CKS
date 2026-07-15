#!/bin/bash
# Only needed if the killercoda default-deny scenario doesn't already give
# you the prod/data namespaces + pods. Recreates the test topology.
set -e

kubectl create ns prod --dry-run=client -o yaml | kubectl apply -f -
kubectl create ns data --dry-run=client -o yaml | kubectl apply -f -
kubectl label ns prod env=prod --overwrite
kubectl label ns data env=data --overwrite

kubectl run default --image=nginx -n default --dry-run=client -o yaml | kubectl apply -f -
kubectl run prod --image=nginx -n prod --dry-run=client -o yaml | kubectl apply -f -
kubectl run data --image=nginx -n data --dry-run=client -o yaml | kubectl apply -f -

kubectl expose pod -n data data --port 80
kubectl expose pod -n prod prod --port 80

echo "[OK] prod/data namespaces + pods + services ready for NetworkPolicy practice."
