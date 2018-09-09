all: apply-sql-proxy apply-web apply-external-dns

apply-sql-proxy:
	kubectl apply -f sql-proxy

apply-web:
	kubectl apply -f web

apply-exercises-js:
	kubectl delete jobs exercises-javascript-job
	kubectl apply -f exercises-javascript.job.yml

apply-exercises-php:
	kubectl delete jobs exercises-php-job
	kubectl apply -f exercises-php.job.yml

apply-external-dns:
	kubectl apply -f external-dns

get-pods:
	kubectl get pod -w

describe-web:
	kubectl describe pod web

log-web:
	kubectl logs -lapp=web -c phoenix

delete-web:
	kubectl delete pods -l web

start-bash:
	kubectl delete pods alpine || true
	kubectl run -i --tty alpine --image=alpine --restart=Never -- sh
