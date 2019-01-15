S := app

PROJECT := hexlet-basics

include make-compose.mk
include make-services-app.mk
include make-gcp.mk

setup:
	mkdir -p tmp
	touch tmp/ansible-vault-password
	docker run -v $(CURDIR):/app -w /app williamyeh/ansible:ubuntu18.04 ansible-playbook ansible/development.yml -i ansible/development -vv -K

docker-init:
	gcloud auth configure-docker

terraform-vars-generate:
	docker run -it -v $(CURDIR):/app -w /app ansible ansible-playbook ansible/terraform.yml -i ansible/production -vv --vault-password-file=tmp/ansible-vault-password

ansible-vaults-edit:
	ansible-vault edit ansible/production/group_vars/all/vault.yml --vault-password-file=tmp/ansible-vault-password
# gcloud auth application-default login
# gcloud config set project hexlet-basics
gcloud-cluster-init:
	gcloud container clusters get-credentials hexlet-basics-5 --region europe-west3-a --project ${PROJECT}
