kube-migrate:
	kubectl exec -it $(shell kubectl get --no-headers=true pods -o custom-columns=:metadata.name) -c phoenix mix ecto.migrate
