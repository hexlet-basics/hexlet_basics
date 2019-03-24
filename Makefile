S := app

PROJECT := hexlet-basics

include make-compose.mk
include make-services-app.mk
include make-gcp.mk

project-setup: project-files-touch project-env-generate compose-setup

project-files-touch:
	mkdir -p tmp
	touch tmp/ansible-vault-password

project-env-generate:
	docker run -v $(CURDIR):/app -w /app williamyeh/ansible:ubuntu18.04 ansible-playbook ansible/development.yml -i ansible/development -vv -K

docker-init:
	gcloud auth configure-docker

terraform-vars-generate:
	docker run -it -v $(CURDIR):/app -w /app ansible ansible-playbook ansible/terraform.yml -i ansible/production -vv --vault-password-file=tmp/ansible-vault-password

ansible-vaults-edit:
	ansible-vault edit ansible/production/group_vars/all/vault.yml --vault-password-file=tmp/ansible-vault-password
