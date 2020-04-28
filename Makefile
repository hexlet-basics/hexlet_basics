S := web
VERSION := latest
PROJECT := hexlet-basics

include make-compose.mk
include make-services-web.mk
include make-services-caddy.mk
include k8s/Makefile

project-setup: project-files-touch project-env-generate compose-setup
	npm install
	pip install autoenv
	grep -qxF 'source `which activate.sh`' ~/.bash_profile || echo 'source `which activate.sh`' >> ~/.bash_profile
	grep -qxF 'export AUTOENV_ENV_FILENAME=.autoenv' ~/.bash_profile || echo 'export AUTOENV_ENV_FILENAME=.autoenv' >> ~/.bash_profile
	export AUTOENV_ENV_FILENAME=.autoenv
	mkdir .kube

cluster-setup:
	doctl auth init
	doctl kubernetes cluster kubeconfig save hexlet-basics
	kubectx do-fra1-hexlet-basics

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
