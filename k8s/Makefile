all: apply-sql-proxy apply-web apply-external-dns
	kubectl apply -f code.persistent-volume-claim.yml

apply-sql-proxy:
	kubectl apply -f sql-proxy

apply-web:
	kubectl apply -f web

apply-external-dns:
	kubectl apply -f external-dns

get-pods:
	kubectl get pod -w

describe-web:
	kubectl describe pod web

log-web:
	kubectl logs web phoenix

delete-web:
	kubectl delete pods -l web

start-bash:
	kubectl delete pods alpine || true
	kubectl run -i --tty alpine --image=alpine --restart=Never -- sh
