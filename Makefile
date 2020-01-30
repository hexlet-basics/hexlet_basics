S := web
VERSION := latest
PROJECT := hexlet-basics

include make-compose.mk
include make-services-web.mk
include make-services-caddy.mk
include k8s/Makefile

project-setup: project-files-touch project-env-generate compose-setup
	npm install

project-files-touch:
	mkdir -p tmp
	if [ ! -f tmp/ansible-vault-password ]; then echo 'jopa' > tmp/ansible-vault-password; fi;

project-env-generate:
	docker run --rm -e RUNNER_PLAYBOOK=ansible/development.yml \
		-v $(CURDIR)/ansible/development:/runner/inventory \
		-v $(CURDIR):/runner/project \
		ansible/ansible-runner

terraform-vars-generate:
	docker run --rm -e RUNNER_PLAYBOOK=ansible/terraform.yml \
		-v $(CURDIR)/ansible/production:/runner/inventory \
		-v $(CURDIR):/runner/project \
		ansible/ansible-runner

ansible-vaults-edit:
	# docker run -it -v $(CURDIR):/web -w /web ansible ansible-vault edit ansible/production/group_vars/all/vault.yml --vault-password-file=tmp/ansible-vault-password
	docker run -it --rm \
		-v $(CURDIR):/runner/project \
		ansible/ansible-runner ansible-vault edit project/ansible/production/group_vars/all/vault.yml

gcloud-cluster-init:
	gcloud container clusters get-credentials hexlet-basics-6 --region europe-west3-a --project ${PROJECT}
