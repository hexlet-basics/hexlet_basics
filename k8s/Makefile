CURRENT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
KUBE_CONTEXT := gke_hexlet-basics_europe-west3-a_hexlet-basics-6

# kubectl exec app-deployment-5b566d5fb5-q9kdr -c phoenix -- docker pull hexletbasics/exercises-php

init:
	brew install kubernetes-helm

apply-exercises: apply-exercises-go apply-exercises-ruby apply-exercises-elixir apply-exercises-html apply-exercises-css apply-exercises-js apply-exercises-java apply-exercises-racket apply-exercises-php apply-exercises-python

apply-exercises-ruby:
	kubectl delete jobs exercises-ruby-job || true
	kubectl apply -f $(CURRENT_DIR)/exercises-ruby.job.yml

apply-exercises-elixir:
	kubectl delete jobs exercises-elixir-job || true
	kubectl apply -f $(CURRENT_DIR)/exercises-elixir.job.yml

apply-exercises-html:
	kubectl delete jobs exercises-html-job || true
	kubectl apply -f $(CURRENT_DIR)/exercises-html.job.yml

apply-exercises-css:
	kubectl delete jobs exercises-css-job || true
	kubectl apply -f $(CURRENT_DIR)/exercises-css.job.yml

apply-exercises-js:
	kubectl delete jobs exercises-javascript-job || true
	kubectl apply -f $(CURRENT_DIR)/exercises-javascript.job.yml

apply-exercises-java:
	kubectl delete jobs exercises-java-job || true
	kubectl apply -f $(CURRENT_DIR)/exercises-java.job.yml

apply-exercises-racket:
	kubectl delete jobs exercises-racket-job || true
	kubectl apply -f $(CURRENT_DIR)/exercises-racket.job.yml

apply-exercises-php:
	kubectl delete jobs exercises-php-job || true
	kubectl apply -f $(CURRENT_DIR)/exercises-php.job.yml

apply-exercises-python:
	kubectl delete jobs exercises-python-job || true
	kubectl apply -f $(CURRENT_DIR)/exercises-python.job.yml

apply-exercises-go:
	kubectl delete jobs exercises-go-job || true
	kubectl apply -f $(CURRENT_DIR)/exercises-go.job.yml

helm-install: helm-install-nginx-ingress
	helm install app ./app-chart
	helm install -f ./values-external-dns.yml external-dns stable/external-dns

helm-install-nginx-ingress:
	helm install -f ./values-nginx-ingress.yml nginx-ingress nginx-stable/nginx-ingress --set controller.publishService.enabled=true
	kubectl replace nginx-ingress-nginx-ingress -f $(CURRENT_DIR)/nginx-config.yaml

# helm install --name app ./app-chart
helm-upgrade-app:
	helm upgrade  app $(CURRENT_DIR)/app-chart
	git reset HEAD
	git add $(CURRENT_DIR)/app-chart/values.yaml
	git commit -m "deploy"
	git push

# helm install -f ./values-external-dns.yml --name external-dns stable/external-dns
helm-upgrade-external-dns:
	helm upgrade  -f $(CURRENT_DIR)/values-external-dns.yml external-dns stable/external-dns

helm-upgrade-nginx-ingress:
	helm upgrade  -f $(CURRENT_DIR)/values-nginx-ingress.yml nginx-ingress nginx-stable/nginx-ingress
	kubectl replace nginx-ingress-nginx-ingress -f $(CURRENT_DIR)/app-chart/templates/nginx-config.yaml

get-pods:
	kubectl get pod -w -o wide

describe-app:
	kubectl describe pod app

log-app:
	kubectl logs -lapp=app -c phoenix

start-bash:
	kubectl delete pods alpine || true
	kubectl run -i --tty alpine --image=alpine --restart=Never -- sh
