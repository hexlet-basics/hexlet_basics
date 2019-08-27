S := app
TAG := latest
PROJECT := hexlet-basics

include make-compose.mk
include make-services-app.mk
include make-gcp.mk
include k8s/Makefile

project-setup: project-files-touch docker-ansible-build-image project-env-generate compose-setup

project-files-touch:
	mkdir -p tmp
	touch tmp/ansible-vault-password

project-env-generate:
	docker run -it -v $(CURDIR):/app -w /app ansible ansible-playbook ansible/development.yml -i ansible/development -vv

docker-init:
	gcloud auth configure-docker

terraform-vars-generate:
	docker run -it -v $(CURDIR):/app -w /app ansible ansible-playbook ansible/terraform.yml -i ansible/production -vv --vault-password-file=tmp/ansible-vault-password

ansible-vaults-edit:
	docker run -it -v $(CURDIR):/app -w /app ansible ansible-vault edit ansible/production/group_vars/all/vault.yml --vault-password-file=tmp/ansible-vault-password

docker-ansible-build-image:
	docker build -t ansible ansible

tag:
	git tag $(TAG) && git push --tags
