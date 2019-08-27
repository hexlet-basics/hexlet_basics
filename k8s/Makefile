CURRENT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))
KUBE_CONTEXT := gke_hexlet-basics_europe-west3-a_hexlet-basics-6

# kubectl exec app-deployment-5b566d5fb5-q9kdr -c phoenix -- docker pull hexletbasics/exercises-php

init:
	brew install kubernetes-helm
	helm repo add rimusz https://charts.rimusz.net
	helm repo update

apply-exercises: apply-exercises-ruby apply-exercises-elixir apply-exercises-html apply-exercises-css apply-exercises-js apply-exercises-java apply-exercises-racket apply-exercises-php apply-exercises-python

apply-exercises-ruby:
	kubectl delete jobs exercises-ruby-job || true
	kubectl apply -f $(CURRENT_DIR)/app-chart/templates/jobs/exercises-ruby.job.yml

apply-exercises-elixir:
	kubectl delete jobs exercises-elixir-job || true
	kubectl apply -f $(CURRENT_DIR)/app-chart/templates/jobs/exercises-elixir.job.yml

apply-exercises-html:
	kubectl delete jobs exercises-html-job || true
	kubectl apply -f $(CURRENT_DIR)/app-chart/templates/jobs/exercises-html.job.yml

apply-exercises-css:
	kubectl delete jobs exercises-css-job || true
	kubectl apply -f $(CURRENT_DIR)/app-chart/templates/jobs/exercises-css.job.yml

apply-exercises-js:
	kubectl delete jobs exercises-javascript-job || true
	kubectl apply -f $(CURRENT_DIR)/app-chart/templates/jobs/exercises-javascript.job.yml

apply-exercises-java:
	kubectl delete jobs exercises-java-job || true
	kubectl apply -f $(CURRENT_DIR)/app-chart/templates/jobs/exercises-java.job.yml

apply-exercises-racket:
	kubectl delete jobs exercises-racket-job || true
	kubectl apply -f $(CURRENT_DIR)/app-chart/templates/jobs/exercises-racket.job.yml

apply-exercises-php:
	kubectl delete jobs exercises-php-job || true
	kubectl apply -f $(CURRENT_DIR)/app-chart/templates/jobs/exercises-php.job.yml

apply-exercises-python:
	kubectl delete jobs exercises-python-job || true
	kubectl apply -f $(CURRENT_DIR)/app-chart/templates/jobs/exercises-python.job.yml

# helm install --name app ./app-chart
helm-upgrade-app:
	helm upgrade --kube-context=$(KUBE_CONTEXT) app $(CURRENT_DIR)/app-chart

# helm install -f ./values-external-dns.yml --name external-dns stable/external-dns
helm-upgrade-external-dns:
	helm upgrade --kube-context=$(KUBE_CONTEXT) -f $(CURRENT_DIR)/values-external-dns.yml external-dns stable/external-dns

# helm install -f ./values-gcloud-proxy.yml --name pg-sqlproxy rimusz/gcloud-sqlproxy
helm-upgrade-gcloud-sqlproxy:
	helm upgrade --kube-context=$(KUBE_CONTEXT) -f $(CURRENT_DIR)/values-gcloud-proxy.yml pg-sqlproxy rimusz/gcloud-sqlproxy

get-pods:
	kubectl get pod -w

describe-app:
	kubectl describe pod app

log-app:
	kubectl logs -lapp=app -c phoenix

start-bash:
	kubectl delete pods alpine || true
	kubectl run -i --tty alpine --image=alpine --restart=Never -- sh
