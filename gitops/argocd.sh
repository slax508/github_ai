#!/bin/bash

kubectl create namespace argocd

kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml


echo "Waiting for ArgoCD components to be ready..."
kubectl wait --for=condition=available --timeout=600s deployment --all -n argocd


kubectl patch svc argocd-server -n argocd -p '{"spec": {"type": "NodePort"}}'


echo "ArgoCD server NodePort details:"
kubectl get svc argocd-server -n argocd
