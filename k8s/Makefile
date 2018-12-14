init:
	brew install helm-?
	helm repo add rimusz https://charts.rimusz.net
	helm repo update

apply-exercises-js:
	kubectl delete jobs exercises-javascript-job || true
	kubectl apply -f exercises-javascript.job.yml

apply-exercises-php:
	kubectl delete jobs exercises-php-job || true
	kubectl apply -f exercises-php.job.yml

apply-exercises-python:
	kubectl delete jobs exercises-python-job || true
	kubectl apply -f exercises-python.job.yml

# helm install --name app ./app-chart
helm-upgrade-app:
	helm upgrade app ./app-chart

# helm install -f ./values-external-dns.yml --name external-dns stable/external-dns
helm-upgrade-external-dns:
	helm upgrade -f ./values-external-dns.yml external-dns stable/external-dns

# helm install -f ./values-gcloud-proxy.yml --name pg-sqlproxy rimusz/gcloud-sqlproxy
helm-upgrade-gcloud-sqlproxy:
	helm upgrade -f ./values-gcloud-proxy.yml pg-sqlproxy rimusz/gcloud-sqlproxy

get-pods:
	kubectl get pod -w

describe-app:
	kubectl describe pod app

log-app:
	kubectl logs -lapp=app -c phoenix

start-bash:
	kubectl delete pods alpine || true
	kubectl run -i --tty alpine --image=alpine --restart=Never -- sh
