U := ubuntu
E := development

ansible-exercises-load:
	ansible-playbook ansible/exercises.yml -i ansible/$E -u $U -vv

ansible-deps-install:
	ansible-galaxy install -r requirements.yml

ansible-site-setup:
	ansible-playbook ansible/site.yml -i ansible/production -u $U

ansible-site-update-env:
	ansible-playbook ansible/site.yml -i ansible/production -u $U --tag env

ansible-site-update-exercise-images:
	ansible-playbook ansible/site.yml -i ansible/production -u $U --tag images

ansible-site-deploy:
	ansible-playbook ansible/deploy.yml -i ansible/production -u $U

ansible-vaults-encrypt:
	ansible-vault encrypt ansible/production/group_vars/all/vault.yml
	ansible-vault encrypt ansible/development/group_vars/all/vault.yml

ansible-vaults-decrypt:
	ansible-vault decrypt ansible/production/group_vars/all/vault.yml
	ansible-vault decrypt ansible/development/group_vars/all/vault.yml

ansible-development-setup:
	mkdir -p tmp
	touch tmp/ansible-vault-password
	ansible-playbook ansible/development.yml -i ansible/development -vv -K

ansible-terraform-vars-generate:
	ansible-playbook ansible/terraform.yml -i ansible/production -vv
