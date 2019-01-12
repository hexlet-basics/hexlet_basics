KUBE_CONTEXT := gke_hexlet-basics_europe-west3-a_hexlet-basics-5

init:
	brew install helm-?
	helm repo add rimusz https://charts.rimusz.net
	helm repo update

apply-exercises-js:
	kubectl delete --kube-context=$(KUBE_CONTEXT) jobs exercises-javascript-job || true
	kubectl apply --kube-context=$(KUBE_CONTEXT) -f exercises-javascript.job.yml

apply-exercises-php:
	kubectl delete --kube-context=$(KUBE_CONTEXT) jobs exercises-php-job || true
	kubectl apply --kube-context=$(KUBE_CONTEXT) -f exercises-php.job.yml

apply-exercises-python:
	kubectl delete --kube-context=$(KUBE_CONTEXT) jobs exercises-python-job || true
	kubectl apply --kube-context=$(KUBE_CONTEXT) -f exercises-python.job.yml

# helm install --name app ./app-chart
helm-upgrade-app:
	helm upgrade --kube-context=$(KUBE_CONTEXT) app ./app-chart

# helm install -f ./values-external-dns.yml --name external-dns stable/external-dns
helm-upgrade-external-dns:
	helm upgrade --kube-context=$(KUBE_CONTEXT) -f ./values-external-dns.yml external-dns stable/external-dns

# helm install -f ./values-cert-manager.yml --name cert-manager --namespace kube-system stable/cert-manager
helm-upgrade-cert-manager:
	helm upgrade --kube-context=$(KUBE_CONTEXT) -f ./values-cert-manager.yml cert-manager stable/cert-manager

# helm install -f ./values-gcloud-proxy.yml --name pg-sqlproxy rimusz/gcloud-sqlproxy
helm-upgrade-gcloud-sqlproxy:
	helm upgrade --kube-context=$(KUBE_CONTEXT) -f ./values-gcloud-proxy.yml pg-sqlproxy rimusz/gcloud-sqlproxy

get-pods:
	kubectl get pod -w

describe-app:
	kubectl describe pod app

log-app:
	kubectl logs -lapp=app -c phoenix

start-bash:
	kubectl delete pods alpine || true
	kubectl run -i --tty alpine --image=alpine --restart=Never -- sh
